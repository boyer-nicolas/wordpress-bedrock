#!/bin/bash

set -e

source /home/niwee/bin/utils.sh

if [ ! -f "/home/niwee/setupdone" ]; then

	if [[ $WP_ENV == "development" ]]; then
		info "Generating server certificates..."
		mkdir -p /home/niwee/ssl/{private,certs}
		if openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /home/niwee/ssl/private/wp.key -out /home/niwee/ssl/certs/wp.crt -subj '/CN=wordpress.localhost'; then
			success "Certificates generated successfully."
		else
			error "Failed to generate certificates."
			exit 1
		fi
	fi

	info "Linking app to server root..."
	cd /var/www
	sudo rm -rf html

	sudo ln -s ${APP_DIR} /var/www/html

	cd /var/www/html

	if [[ $ENVIRONMENT == "production" ]]; then
		info "Installing production dependencies..."
		if composer install --optimize-autoloader --no-dev; then
			success "Dependencies installed successfully."
		else
			error "Failed to install dependencies."
			exit 1
		fi

		info "Updating file permissions..."
		if sudo chown -R niwee:$PUID $APP_DIR $HOME/.bashrc /var/www/html && find /var/www/html/ -type f -exec sudo chmod 644 -- {} + && find /var/www/html/ -type d -exec sudo chmod 755 -- {} +; then
			success "File permissions updated successfully."
		else
			error "Failed to update file permissions."
			exit 1
		fi
	else
		info "Installing development dependencies..."
		if composer install --optimize-autoloader; then
			success "Dependencies installed successfully."
		else
			error "Failed to install dependencies."
			exit 1
		fi
	fi

	if [ -f "${APP_DIR}/.gitattributes" ]; then
		info "Pulling LFS files..."
		cd $APP_DIR
		if git lfs pull; then
			success "LFS files pulled successfully."
		else
			error "Failed to pull LFS files."
			exit 1
		fi
		cd /var/www/html

		info "Removing .gitattributes file..."
		if rm ${APP_DIR}/.gitattributes; then
			success ".gitattributes file removed successfully."
		else
			error "Failed to remove .gitattributes file."
			exit 1
		fi
	fi

	# Check if dump sql is there
	info "Looking for sql files..."
	if [ ! -f "$APP_DIR/sql/dump.sql" ]; then
		warning "Missing $APP_DIR/sql/dump.sql"
		# Pulling media
		log "Pulling medias"
		if /home/niwee/bin/media pull; then
			success "Medias pulled successfully."
		else
			error "Failed to pull medias."
			exit 1
		fi
	fi

	# Check if there is any directory in the plugins folder
	info "Looking for plugins..."
	PLUGINS_DIR="$APP_DIR/web/app/plugins/"

	PLUGIN_FOUND="false"

	for d in "$PLUGINS_DIR"*/; do
		if [ -d "$d" ]; then
			PLUGIN_FOUND="true"
		fi
	done

	if [[ $PLUGIN_FOUND == "false" ]]; then
		warning "Missing plugins"
		# Pulling media
		log "Pulling medias"
		if /home/niwee/bin/media pull; then
			success "Medias pulled successfully."
		else
			error "Failed to pull medias."
			exit 1
		fi
	fi

	MYSQL_ADMIN="--host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_ROOT_USER --password=$MYSQL_ROOT_PASSWORD"
	MYSQL_ARGS="--host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASSWORD"

	if [ "$WP_ENV" = "development" ]; then
		URL=$WP_DEV_URL
	elif [ "$WP_ENV" = "staging" ]; then
		URL=$WP_STAGING_URL
	elif [ "$WP_ENV" = "production" ]; then
		URL=$WP_PROD_URL
	fi

	log "Site will be available at ${GREEN}$URL${NC}"

	info "Checking database existence..."
	TABLE="niwee_options"

	if [[ $NEED_DATABASE_CREATION == "1" ]]; then

		log "Connected to \e[32m$MYSQL_HOST\033[0m with user \e[32m$MYSQL_USER\033[0m"

		log "Creating user and giving privileges to \e[32m$MYSQL_HOST\033[0m ..."
		mysql $MYSQL_ADMIN -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
		mysql $MYSQL_ADMIN -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}' IDENTIFIED BY '${MYSQL_PASSWORD}';"
		mysql $MYSQL_ADMIN -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER};"

		SQL_EXISTS=$(printf 'SELECT 1 FROM information_schema.tables WHERE table_schema = "%s" LIMIT 1' "$MYSQL_DATABASE")
		SQL_IS_EMPTY=$(printf 'SELECT 1 FROM %s LIMIT 1' "$TABLE")
		if [[ $(mysql $MYSQL_ARGS -e "$SQL_EXISTS" "$MYSQL_DATABASE") ]]; then
			log "Database $MYSQL_DATABASE already exists, skipping creation"
		else
			log "Creating WP database..."
			mysql $MYSQL_ARGS --database="$MYSQL_DATABASE" <$APP_DIR/sql/dump.sql
		fi
	else
		SQL_IS_EMPTY=$(printf 'SELECT 1 FROM %s LIMIT 1' "$TABLE")

		if [[ $(mysql $MYSQL_ARGS -e "$SQL_IS_EMPTY" "$MYSQL_DATABASE") ]]; then
			log "Database $MYSQL_DATABASE already exists, skipping creation"
		else
			if [ -f $APP_DIR/sql/dump.sql ]; then
				log "Creating WP database..."
				mysql $MYSQL_ARGS --database="$MYSQL_DATABASE" <$APP_DIR/sql/dump.sql
			elif [ -f $APP_DIR/sql/dump.sql.bak ]; then
				log "Creating WP database..."
				mysql $MYSQL_ARGS --database="$MYSQL_DATABASE" <$APP_DIR/sql/dump.sql.bak
			else
				log "Creating WP database..."
				wp core install --url="$URL" --title="My New Website" --admin_user="niweeproductions" --admin_password="proutprout" --admin_email="global@niwee.fr" --skip-email
			fi
		fi
	fi

	ok "Database ready"

	if [[ $EXTERNAL_DATABASE == "1" ]]; then
		if !wp --skip-plugins --skip-themes option get siteurl; then
			wp db import $APP_DIR/sql/dump.sql
		fi
	fi

	###
	# Change site url if it does not match the requested URI
	###
	log "Checking site url"
	wp option get siteurl
	CURRENT_SITE_URL=$(wp option get siteurl)
	STRIPED_CURRENT_SITE_URL=$(echo ${CURRENT_SITE_URL} | sed 's/https:\/\///g')
	STRIPED_TARGET_URL=$(echo ${URL} | sed 's/https:\/\///g')
	if [[ ${CURRENT_SITE_URL} != "https://${URL}" ]]; then
		info "Changing siteurl to ${URL}"

		wp search-replace --all-tables ${CURRENT_SITE_URL} ${URL} &>/dev/null
		wp search-replace --all-tables ${STRIPED_CURRENT_SITE_URL} ${STRIPED_TARGET_URL} &>/dev/null

		ok "Site url changed"
	fi

	info "Flushing cache"
	if wp cache flush; then
		ok "Cache flushed"
	else
		log "Cache flush failed"
	fi
	touch /home/niwee/setupdone
fi

# Configure cron
log "Configuring cron"
# Cron custom scripts location
CRON_SCRIPTS_DIR="/home/niwee/bin/cron"

CRON_FILE=""
if [[ $WP_ENV == "development" ]]; then
	CRON_FILE="$CRON_SCRIPTS_DIR/dev-cron"
elif [[ $WP_ENV == "staging" ]]; then
	CRON_FILE="$CRON_SCRIPTS_DIR/staging-cron"
elif [[ $WP_ENV == "production" ]]; then
	CRON_FILE="$CRON_SCRIPTS_DIR/prod-cron"
fi

# Copy cron file
sudo cp $CRON_FILE /etc/crontabs/root

# Start cron
log "Starting cron"
sudo crond -f -d 8 &

exec "$@"
