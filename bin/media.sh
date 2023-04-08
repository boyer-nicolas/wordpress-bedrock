#!/bin/bash
set -e
source ./bin/env.sh
source ./bin/messages.sh

info "Running media script"

stackIsUp() {
    $DC ps | grep -q "Up"
}

mediaPush() {
    if ! stackIsUp; then
        error "Stack is not up, Exiting."
    else
        $DC exec wordpress bash -c 'media push'
    fi
}

mediaPull() {
    if ! stackIsUp; then
        error "Stack is not up, Exiting."
    else
        $DC exec wordpress bash -c 'media pull'
    fi
}

# Router
case "$1" in
push)
    mediaPush
    ;;
pull)
    mediaPull
    ;;
*)
    echo "Usage: $0 {pull|push}"
    exit 1
    ;;
esac
