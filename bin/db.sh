#!/bin/bash
set -e
source ./bin/env.sh
source ./bin/messages.sh

info "Running database script"

stackIsUp() {
    $DC ps | grep -q "Up"
}

wpDbImport() {
    if ! stackIsUp; then
        error "Stack is not up, Exiting."
    else
        # TODO: fix validation messages
        await "Importing database ... "
        if $DC exec wordpress bash -c "$WP db import /home/niwee/app/sql/dump.sql"; then
            success "Database imported"
        else
            fail
            exit 1
        fi

        await "Changing siteurl ... "
        CURRENT_URL=$($DC exec wordpress bash -c "$WP option get siteurl")
        if $DC exec wordpress bash -c "$WP search-replace --all-tables '$CURRENT_URL' 'https://wordpress.localhost'"; then
            success "Siteurl changed"
        else
            fail
            exit 1
        fi

        await "Flushing cache ... "
        if $DC exec wordpress bash -c "$WP cache flush"; then
            success "Cache flushed"
        else
            fail
            exit 1
        fi
    fi

}

wpDbDump() {
    if ! stackIsUp; then
        error "Stack is not up, Exiting."
    else
        await "Exporting database"
        if $DC exec wordpress bash -c "$WP db export /home/niwee/app/sql/dump.sql"; then
            success
        else
            fail
            exit 1
        fi
    fi
}

# Router
case "$1" in
import)
    wpDbImport
    ;;
dump)
    wpDbDump
    ;;
*)
    echo "Usage: $0 {import|dump}"
    exit 1
    ;;
esac
