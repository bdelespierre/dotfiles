#!/usr/bin/env bash

PS1_MODULES["timer"]="__ps1_timer"

__ps1_timer () {
    local -n output="$1"; output=""
    local time=$(($SECONDS - ${PROMPT_TIMER:-$SECONDS}))
    local code=${PS1_EXIT_CODE:-0}
    local color

    if [[ "$code" == 0 || "$code" == 130 ]]
        then color="${PS1_COLORS[green]}"
        else color="${PS1_COLORS[red]}"
    fi

    output="${color}${time:-0}s${PS1_COLORS[default]}"

    unset PROMPT_TIMER
}

__ps1_timer_trap () {
    PROMPT_TIMER=${PROMPT_TIMER:-$SECONDS}
}

trap '__ps1_timer_trap' DEBUG
