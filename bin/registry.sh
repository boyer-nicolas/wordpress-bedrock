#!/bin/bash
set -e

source ./bin/env.sh
source ./bin/messages.sh

CREDENTIALS_FILE="$HOME/.niwee-docker-credentials"

if [ -f "$CREDENTIALS_FILE" ]; then
    message "Found existing credentials file. Skipping registry configuration."
    exit 0
fi

message "You're about to configure registry credentials for the watchtower container."

prompt "Enter registry username: " REGISTRY_USERNAME
promptPassword "Enter registry password: " REGISTRY_PASSWORD

CONFIG_PATTERN='{
    "auths": {
        "registry.byniwee.cloud": {
            "auth": "encoded_credentials"
        }
    }
}'

await "Logging in to registry... "
echo -n "$REGISTRY_PASSWORD" | docker login registry.byniwee.cloud -u "$REGISTRY_USERNAME" --password-stdin

info "Ecoding credentials... "
ENCODED_CREDENTIALS=$(echo -n "$REGISTRY_USERNAME:$REGISTRY_PASSWORD" | base64)

info "Writing credentials file... "
CONFIG=$(echo "$CONFIG_PATTERN" | sed "s/encoded_credentials/$ENCODED_CREDENTIALS/g")

echo "$CONFIG" >"$CREDENTIALS_FILE"

success "Registry credentials configured."
