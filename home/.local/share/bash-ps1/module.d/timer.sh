#!/usr/bin/env bash

PS1_MODULES["timer"]="__ps1_timer"

__ps1_timer () {
    local -n output="$1"; output=""
    local time=$(($SECONDS - ${PROMPT_TIMER:-$SECONDS}))
    local code=${PS1_EXIT_CODE:-0}
    local color

    if [[ "$code" == 0 || "$code" == 130 ]]
        then color="${BASH_COLORS[green]}"
        else color="${BASH_COLORS[red]}"
    fi

    output="${color}${time:-0}s${BASH_COLORS[reset]}"

    unset PROMPT_TIMER
}

__ps1_timer_trap () {
    PROMPT_TIMER=${PROMPT_TIMER:-$SECONDS}
}

trap '__ps1_timer_trap' DEBUG
