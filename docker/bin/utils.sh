#!/bin/bash
set -e

# Source bashrc
source $HOME/.bashrc
source $HOME/bin/messages.sh

# Legacy Functions kept to prevent breaking changes
function write_status {
    info "$1"
}

function ok {
    success "$1"
}

function fail {
    error "$1"
}

function log {
    info "$1"
}
