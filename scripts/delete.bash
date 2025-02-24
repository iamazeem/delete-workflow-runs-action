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

    local GH_RUN_LIST_ARGS=" --limit 100"

    if [[ -n $INCLUDE_DISABLED_WORKFLOWS ]]; then
        GH_RUN_LIST_ARGS+=" --all"
    fi
    if [[ -n $BRANCH ]]; then
        GH_RUN_LIST_ARGS+=" --branch $BRANCH"
    fi
    if [[ -n $COMMIT_SHA ]]; then
        GH_RUN_LIST_ARGS+=" --commit $COMMIT_SHA"
    fi
    if [[ -n $CREATION_DATE ]]; then
        GH_RUN_LIST_ARGS+=" --created $CREATION_DATE"
    fi
    if [[ -n $EVENT ]]; then
        GH_RUN_LIST_ARGS+=" --event $EVENT"
    fi
    if [[ -n $STATUS ]]; then
        GH_RUN_LIST_ARGS+=" --status $STATUS"
    fi
    if [[ -n $USERNAME ]]; then
        GH_RUN_LIST_ARGS+=" --user $USERNAME"
    fi
    if [[ -n $WORKFLOW ]]; then
        GH_RUN_LIST_ARGS+=" --workflow $WORKFLOW"
    fi

    if ((KEEP > 0)); then
        ((KEEP += 1))
    fi

    local DELETE_COUNT=0

    while :; do
        # shellcheck disable=SC2086
        RUN_IDS=$(gh run list $GH_RUN_LIST_ARGS --json databaseId --jq '.[] | join("")' | tail -n +"$KEEP")
        if [[ -z $RUN_IDS ]]; then
            break
        fi

        for RUN_ID in $RUN_IDS; do
            echo "x Deleting $RUN_ID"
            gh run delete "$RUN_ID" >/dev/null
            ((DELETE_COUNT += 1))
        done
    done

    echo "$DELETE_COUNT workflow run(s) deleted!"

    echo "::endgroup::"
}

# start

delete
