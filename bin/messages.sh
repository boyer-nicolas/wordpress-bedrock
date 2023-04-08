#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
NC='\033[0m'

# Messages
function message {
    echo -e "${GREEN}==>${NC} $1"
}

function info {
    echo -e "${BLUE}==>${NC} $1"
}

function warning {
    echo -e "${MAGENTA}==>${NC} $1"
}

function error {
    echo -e "${RED}==>${NC} $1"
}

function await {
    echo -ne "${BLUE}==>${NC} $1"
}

function success {
    if [ -z "$1" ]; then
        echo -e "[${GREEN}OK${NC}]"
    else
        echo -e "${GREEN}==>${NC} $1"
    fi
}

function fail {
    echo -e "[${RED}FAIL${NC}]"
    exit 1
}

function prompt {
    QUESTION=$1
    VARIABLE=$2
    echo -ne "${BLUE}==>${NC} $QUESTION"
    read -p " " $VARIABLE

    RESULT=$(eval echo \$$2)

    if [ -z "$RESULT" ]; then
        echo -ne "${RED}==>${NC} $QUESTION"
        read -p " " $VARIABLE

        RESULT=$(eval echo \$$2)

        if [ -z "$RESULT" ]; then
            echo -e "${RED}==>${NC} Missing $VARIABLE. Exiting."
            exit 1
        fi
    fi
}

function promptPassword {
    QUESTION=$1
    VARIABLE=$2
    echo -ne "${BLUE}==>${NC} $QUESTION"
    read -s -p " " $VARIABLE

    RESULT=$(eval echo \$$2)

    if [ -z "$RESULT" ]; then
        echo -ne "${RED}==>${NC} $QUESTION"
        read -p " " $VARIABLE

        RESULT=$(eval echo \$$2)

        if [ -z "$RESULT" ]; then
            echo -e "${RED}==>${NC} Missing $VARIABLE. Exiting."
            exit 1
        fi
    fi
    echo
}
