#!/usr/bin/env bash

PS1_MODULES["user_host"]="__ps1_user_host"

__ps1_user_host () {
    local -n output="$1"; output=""
    local user="${PS1_USER:-\\u}"
    local host="${PS1_HOST:-\\h}"

    # %user%@%hostname%
    output+="${BASH_COLORS[green]}${user@P}"
    output+="${BASH_COLORS[dark_gray]}@"
    output+="${BASH_COLORS[green]}${host@P}"
    output+="${BASH_COLORS[reset]}"
}
