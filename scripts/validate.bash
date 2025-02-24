#!/bin/bash

set -eE -o functrace

fatal() {
    local LINE="$1"
    local CMD="$2"
    echo "[FATAL] $LINE: $CMD"
    exit 1
}

trap 'fatal "$LINENO" "$BASH_COMMAND"' ERR

# functions

validate_environment() {
    echo "::group::Validating environment"

    echo "BASH_VERSION: [$BASH_VERSION]"

    echo "Validating GitHub CLI (gh)"
    if ! which gh; then
        echo "gh command not found!"
        exit 1
    else
        gh --version
    fi

    echo "::endgroup::"
}

validate_inputs() {
    echo "::group::Validating inputs"

    # TODO: Validate inputs

    echo "::endgroup::"
}

# start

validate_environment
validate_inputs
