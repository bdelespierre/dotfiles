#!/usr/bin/env bash

PS1_MODULES["time"]="__ps1_time"

__ps1_time () {
    local -n output="$1"; output=""
    local time="\\@"

    time="${time@P}"
    time="${time%" PM"}"
    time="${time%" AM"}"
    time=(${time//:/ })

    # %h:i%
    output+="${BASH_COLORS[yellow]}${time[0]}"
    output+="${BASH_COLORS[dark_gray]}:"
    output+="${BASH_COLORS[yellow]}${time[1]}"
    output+="${BASH_COLORS[reset]}"
}
