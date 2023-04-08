#!/bin/bash
set -e

source ./bin/messages.sh

info "Loading environment variables"

if [ ! -f ".env" ]; then
    warning "No .env file found. Skipping"
else
    source .env

    COMPOSE_FILE="docker-compose.yml"

    if [ ! -z "$WP_ENV" ]; then
        if [ "$WP_ENV" = "development" ]; then
            COMPOSE_FILE="docker-compose.yml"
        elif [ "$WP_ENV" = "staging" ]; then
            COMPOSE_FILE="docker-compose.staging.yml"
        elif [ "$WP_ENV" = "production" ]; then
            COMPOSE_FILE="docker-compose.prod.yml"
        fi
    fi

    # URL can be one of WP_DEV_URL, WP_STAGING_URL or WP_PROD_URL
    # WP env is represented by WP_ENV

    if [ "$WP_ENV" = "development" ]; then
        URL=$WP_DEV_URL
    elif [ "$WP_ENV" = "staging" ]; then
        URL=$WP_STAGING_URL
    elif [ "$WP_ENV" = "production" ]; then
        URL=$WP_PROD_URL
    fi
fi

DC="docker compose -f $COMPOSE_FILE"
WP="wp --allow-root"
