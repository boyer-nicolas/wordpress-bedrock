#!/bin/bash
set -e
source ./bin/messages.sh

source ./bin/env.sh

CURRENT_URL=$($DC exec wordpress bash -c "wp option get siteurl")

info "Changing siteurl from $CURRENT_URL to $URL"
$DC exec wordpress bash -c "wp search-replace --all-tables '$CURRENT_URL' '$URL'"
