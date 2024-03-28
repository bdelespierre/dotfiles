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
            then color="${PS1_COLORS[green]}"
            else color="${PS1_COLORS[yellow]}"
        fi

        jobs+=("${PS1_COLORS[dark_gray]}$1${color}$3${PS1_COLORS[default]}")
    done < <(jobs)

    if [[ -n "${jobs:-}" ]]; then
        output="${jobs[@]}${PS1_COLORS[default]}"
    fi
}
