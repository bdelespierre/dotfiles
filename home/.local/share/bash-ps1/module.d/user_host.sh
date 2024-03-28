#!/usr/bin/env bash

PS1_MODULES["user_host"]="__ps1_user_host"

__ps1_user_host () {
    local -n output="$1"; output=""
    local user="${PS1_USER:-\\u}"
    local host="${PS1_HOST:-\\h}"

    # %user%@%hostname%
    output+="${PS1_COLORS[green]}${user@P}"
    output+="${PS1_COLORS[dark_gray]}@"
    output+="${PS1_COLORS[green]}${host@P}"
    output+="${PS1_COLORS[default]}"
}
