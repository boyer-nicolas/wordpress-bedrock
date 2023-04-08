#!/bin/bash
set -e

source ./bin/env.sh
source ./bin/messages.sh

EXEC="$DC exec wordpress bash -c"

# Create users
info "Creating users"
$EXEC "$WP user create nicolasboyer nicolas@niwee.fr --role=administrator --user_pass=proutprout  --display_name='Nicolas Boyer' --first_name='Nicolas' --last_name='Boyer' --nickname='nicolasboyer'" || true
$EXEC "$WP user create wilfriedrolland will@niwee.fr  --role=administrator --user_pass=proutprout --display_name='Wilfried Rolland' --first_name='Wilfried' --last_name='Rolland' --nickname='wilfriedrolland'" || true
$EXEC "$WP user create williamfernandes william-fernandes@niwee.fr --role=administrator --user_pass=proutprout  --display_name='William Fernandes' --first_name='William' --last_name='Fernandes' --nickname='williamfernandes'" || true

# Delete Sample Page
info "Deleting sample page"
$EXEC "$WP post delete 2 --force" || true

# Create pages
info "Creating pages"
$EXEC "$WP post create --post_type=page --post_title='Politique de confidentialité' --post_status=publish" || true
$EXEC "$WP post create --post_type=page --post_title='Mentions légales' --post_status=publish" || true

# Modify permalinks
info "Modifying permalinks"
$EXEC "$WP rewrite structure '/%postname%/' --hard" || true

# Modify date format
info "Modifying date format"
$EXEC "$WP option update date_format 'd/m/Y'" || true
$EXEC "$WP option update time_format 'H:i'" || true
$EXEC "$WP option update timezone_string 'Europe/Paris'" || true
$EXEC "$WP option update start_of_week '1'" || true
