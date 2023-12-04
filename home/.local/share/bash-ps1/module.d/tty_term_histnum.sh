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
    output+="${BASH_COLORS[dark_gray]}#${BASH_COLORS[blue]}${tty}"
    output+="${BASH_COLORS[dark_gray]}#${BASH_COLORS[blue]}${shell}"
    output+="${BASH_COLORS[dark_gray]}!${BASH_COLORS[magenta]}${histnum}"
    output+="${BASH_COLORS[reset]}"
}
