#!/bin/bash -e

## File: repo-log.sh
## Prints differences of WHOLE repository to official revisions found in manifest
## use DIFF=1 repo-log.sh to show diff to revision

if [[ $# -eq 0 ]]; then
    ri="$(repo info)" repo forall -c "$0 internal"
elif [[ $# -eq 1 ]]; then
    path=$(git rev-parse --show-toplevel)
    revision=$(grep -1 "Mount path: $path\$" <<< "$ri" | grep "Current revision")
    revision=${revision#"Current revision: "}
    if [[ "$DIFF" -eq 1 ]]; then
        out=$(git --no-pager diff-index --patch origin/$revision)
        if [ ! -z "$out" ]; then
            echo -n "[$revision] "
            git rev-parse --show-toplevel
            echo "$out"
        fi
    else
        # nice format but you can put anything you like here
        out=$(git --no-pager log \
            --graph --abbrev-commit --decorate \
            --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%<(103,trunc)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' \
            origin/$revision..HEAD)
            # --name-only \
        if [ ! -z "$out" ]; then
            echo -n "[$revision] "
            git rev-parse --show-toplevel
            echo "$out"
            echo 
        fi
    fi
else
    echo 'wrong usage'
    exit 1
fi
