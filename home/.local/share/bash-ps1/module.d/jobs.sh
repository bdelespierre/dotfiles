#!/usr/bin/env bash

PS1_MODULES["jobs"]="__ps1_jobs"

__ps1_jobs () {
    local -n output="$1"; output=""
    local color jobs=()

    while read -r line; do
        IFS=" " set -- $line

        if [[ -z $3 ]]; then
            continue
        fi

        if [[ "$2" == "Running" ]]
            then color="${BASH_COLORS[green]}"
            else color="${BASH_COLORS[yellow]}"
        fi

        jobs+=("${BASH_COLORS[dark_gray]}$1${color}$3${BASH_COLORS[reset]}")
    done < <(jobs)

    if [[ -n "${jobs:-}" ]]; then
        output="${jobs[@]}${BASH_COLORS[reset]}"
    fi
}
