#!/bin/bash

# INFO: This script is meant to be run from the docker container.
# TODO: Use messages from the script instead of the echoes
source bin/env.sh
source bin/messages.sh

# Colors
RED='\033[0;31m'    # Red
GREEN='\033[1;32m'  # Green
YELLOW='\033[1;33m' # Yellow
NC='\033[0m'        # No Color

# Messages
CHECK="${YELLOW}Checking:${NC}  "
ERROR="${RED}Error:${NC}     "
SUCCESS="${GREEN}Success:${NC}  "

# Variables
WP_THEME="$($WP --skip-plugins theme list --status=active --field=name)"
CHILD_SUFFIX="-child"
PARENT_THEME=${WP_THEME/%$CHILD_SUFFIX/}

# Paths
WP_CONTENT="/var/www/html/web/app/themes"

# Function to prompt user
ask() {
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
        Y* | y*) return 0 ;;
        N* | n*) return 1 ;;
        esac

    done
}

installNodeJs() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    NVM_DIR=/home/niwee/.nvm
    source $NVM_DIR/nvm.sh
    nvm install --lts
    nvm use --lts
}

function newTheme() {
    echo -e "Creating ${GREEN}$PARENT_THEME$CHILD_SUFFIX${NC} ..."

    # Set themes paths
    OLD_THEME_PATH=$WP_CONTENT/$PARENT_THEME
    NEW_THEME_PATH=$WP_CONTENT/$PARENT_THEME$CHILD_SUFFIX
    CHILD_THEME=$WP_THEME$CHILD_SUFFIX

    FUNCTION_NAME=${CHILD_THEME//-/_}

    # Create child theme directories
    mkdir -p $NEW_THEME_PATH/dist/{css,js}
    mkdir -p $NEW_THEME_PATH/src/{scss,js}

    # Add base files
    touch $NEW_THEME_PATH/{style.css,functions.php} $NEW_THEME_PATH/dist/css/style.min.css $NEW_THEME_PATH/dist/js/script.min.js
    touch $NEW_THEME_PATH/src/{scss/style.scss,scss/_variables.scss,scss/_mixins.scss,scss/_common.scss,js/script.js}
    echo "@import 'variables';" >>$NEW_THEME_PATH/src/scss/style.scss
    echo "@import 'mixins';" >>$NEW_THEME_PATH/src/scss/style.scss
    echo "@import 'common';" >>$NEW_THEME_PATH/src/scss/style.scss
    cp /home/niwee/data/webpack/* $NEW_THEME_PATH/
    cp /home/niwee/data/webpack/.* $NEW_THEME_PATH/
    cd $NEW_THEME_PATH

    installNodeJs

    node -v >.nvmrc

    sudo npm install -g yarn
    yarn config set init-license MIT
    yarn config set init-author-name "NiWee Productions"
    yarn config set init-author-email "hello@niwee.fr"
    yarn config set init-author-url "https://agence.niwee.fr"
    cd $NEW_THEME_PATH
    yarn install

    # Add screenshot

    if [ -f "$OLD_THEME_PATH/screenshot.png" ]; then
        cp $OLD_THEME_PATH/screenshot.png $NEW_THEME_PATH/screenshot.png
    elif [ -f "$OLD_THEME_PATH/screenshot.jpg" ]; then
        cp $OLD_THEME_PATH/screenshot.jpg $NEW_THEME_PATH/screenshot.jpg
    fi

    # Make functions.php
    if [ -f "$NEW_THEME_PATH/functions.php" ]; then
        cat <<EOL >>$NEW_THEME_PATH/functions.php
<?php

add_action('wp_enqueue_scripts', '${FUNCTION_NAME}_enqueue_styles');
function blocksy_child_enqueue_styles()
{
    // Parent CSS
    wp_enqueue_style('parent-style', get_template_directory_uri() . '/style.css');

    // Child CSS
    wp_enqueue_style('child-style', get_stylesheet_uri());

    // Child script
    wp_enqueue_script(
        'niwee-script',
        get_stylesheet_directory_uri() . '/dist/js/script.min.js',
        array('jquery'),
        '1.0',
        true
    );
}


EOL
    fi

    # Make style.css
    if [ -f "$NEW_THEME_PATH/style.css" ]; then
        cat <<EOL >>$NEW_THEME_PATH/style.css
/* 
Theme Name:		 NiWee Productions
Theme URI:		 https://niwee.fr
Description:	 Theme Child for ${PARENT_THEME} by NiWee Productions
Author:			 NiWee Productions
Author URI:		 https://niwee.fr
Template:		 ${PARENT_THEME}
Version:		 1.0.0
Text Domain:	 ${CHILD_THEME}
*/

@import 'dist/css/style.min.css';
EOL
    fi

    # Change active theme to child
    wp theme activate $CHILD_THEME

    return 0
}

echo -e "$CHECK Active theme is ${GREEN}$WP_THEME${NC}."

if [[ $WP_THEME == *"-child" ]]; then
    echo -e "$ERROR Theme is already a child of ${GREEN}$PARENT_THEME${NC}."
else
    if newTheme; then
        echo -e "$SUCCESS Child theme was created and activated."
    else
        echo -e "$ERROR Child theme could not be created."
    fi
fi
