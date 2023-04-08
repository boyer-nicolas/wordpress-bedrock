#!/bin/bash

source /home/niwee/bin/utils.sh

info "Running SSH config script..."

if [ "$WP_ENV" = "development" ]; then
    URL=$WP_DEV_URL
elif [ "$WP_ENV" = "staging" ]; then
    URL=$WP_STAGING_URL
elif [ "$WP_ENV" = "production" ]; then
    URL=$WP_PROD_URL
fi

HOSTNAME=$(cat /etc/hostname)
DATE=$(date +"%d %b %Y at %T")
DATE_DIR=$(date +"%d-%m-%Y-%H-%M-%S")

DOCKER_USER="niwee"

SSH_USER="web"
SSH_HOST="nw5.byniwee.cloud"
SSH_PORT="63290"
SSH_IDENTITY_FILE="/home/$DOCKER_USER/.ssh/id_rsa_nw"

BACKUP_DIR="/home/$DOCKER_USER/backup/$URL/$DATE_DIR"
BACKUP_CONTENT_DIR="$BACKUP_DIR/content"

BACKUP_SQL_DIR=$BACKUP_DIR/sql
BACKUP_SQL_FILE="$BACKUP_SQL_DIR/dump.sql"

WP_CORE_DIR="$APP_DIR/web/wp"
WP_CONTENT_DIR="$APP_DIR/web/app"
WP_UPLOADS_DIR="$WP_CONTENT_DIR/uploads"
WP_SQL_DIR="$APP_DIR/sql"

WP_CLI="wp --path=$WP_CORE_DIR --allow-root"

REPOSITORY_URL=$(git -C $APP_DIR config --get remote.origin.url)
REPOSITORY=$(basename -s .git $REPOSITORY_URL)
BRANCH=$(git -C $APP_DIR rev-parse --abbrev-ref HEAD)

BASE_REMOTE_BACKUP_DIR="/home/$SSH_USER/backup/$URL"
BASE_REMOTE_DATA_DIR="/home/$SSH_USER/public_html/wp-data/data"

REMOTE_BACKUP_DIR="$BASE_REMOTE_BACKUP_DIR/$DATE_DIR"
REMOTE_DATA_DIR="$BASE_REMOTE_DATA_DIR/$REPOSITORY/$BRANCH"

REMOTE_DATA_SQL_DIR="$REMOTE_DATA_DIR/sql/"
REMOTE_DATA_UPLOADS_DIR="$REMOTE_DATA_DIR/uploads/"

SSH_PARAMS="ssh -i $SSH_IDENTITY_FILE -p $SSH_PORT"
SSH_ARGS="$SSH_USER@$SSH_HOST"
RSYNC="rsync -avzh --progress --stats --delete -e "$SSH_PARAMS""
