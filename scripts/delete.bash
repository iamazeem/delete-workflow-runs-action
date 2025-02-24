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

delete() {
    echo "::group::Deleting workflow runs"

    # TODO: Add deletion logic

    echo "::endgroup::"
}

# start

delete
