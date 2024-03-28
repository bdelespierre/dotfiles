#!/usr/bin/env bash

PS1_MODULES["tty_term_histnum"]="__ps1_tty_term_histnum"

__ps1_tty_term_histnum () {
    local -n output="$1"; output=""
    local tty="${PS1_TTY:-\\l}"
    local shell="${PS1_SHELL:-\\s}"
    local histnum="\\!"

    if [[ "$tty" == "auto" ]]; then
        tty="\\l"
        tty="${tty@P}"

        if [[ "${tty:0:3}" != "tty" ]]; then
            tty=$(readlink /dev/fd/0)
            tty=${tty#/dev/}
        fi
    fi

    # #%tty%#%term%!%histnum%
    output+="${PS1_COLORS[dark_gray]}#${PS1_COLORS[blue]}${tty}"
    output+="${PS1_COLORS[dark_gray]}#${PS1_COLORS[blue]}${shell}"
    output+="${PS1_COLORS[dark_gray]}!${PS1_COLORS[magenta]}${histnum}"
    output+="${PS1_COLORS[default]}"
}
