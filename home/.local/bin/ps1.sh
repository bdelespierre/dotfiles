#!/usr/bin/env bash

# usage: source ps1.sh

# -----------------------------------------------------------------------------
# load modules

declare -A PS1_PREFIXES PS1_SUFFIXES
export PS1_PREFIXES PS1_SUFFIXES

declare -A PS1_MODULES
export PS1_MODULES

IFS=':' read -ra dirs <<< "$PS1_PATH"
for dir in "${dirs[@]}"; do
    if [[ -z "$dir" ]] || [[ ! -d "$dir/module.d" ]]; then
        continue
    fi

    for file in "$dir"/module.d/*.sh; do
        source "$file"
    done
done

# -----------------------------------------------------------------------------
# prompt

PROMPT_COMMAND='PS1_EXIT_CODE=$? __ps1_prompt'

__ps1_prompt () {
    local left="" right=""

    if [[ "${PS1_NEWLINE:-1}" == "1" ]]; then
        # newline (does not appear after clear)
        echo >&2
    fi

    __ps1_expand_modules left "${PS1_LEFT[@]}"

    if [[ -n "$left" ]]; then
        if [[ "${PS1_NEWLINE_PROMPT:-1}" == "1" ]];
            then left="$left\n"
            else left="$left "
        fi
    fi

    # print left side
    PS1="$left${BASH_COLORS[dark_gray]}\\\$${BASH_COLORS[reset]} "

    __ps1_expand_modules right "${PS1_RIGHT[@]}"

    if [[ -n "$right" ]]; then
        __ps1_prompt_right "$right"
    fi
}

__ps1_prompt_right () {
    local right="$1"

    # trim trailing spaces
    right="${right%" "}"

    # remove all formatting from $right
    shopt -s extglob
    local right_text="${right//\\\[\\e\[*([^m])m\\\]/}"
    local right_len=${#right_text}

    # determine the lenght of the horizontal padding
    local pad
    for ((i=0; i<COLUMNS-right_len; i++)); do
        pad+=" "
    done

    # print right-side, then return, then print left
    PS1="${pad}${right}\r${PS1}"
}

__ps1_expand_modules () {
    local -n output="$1"; output=""

    shift
    for module in "$@"; do
        if [[ -z "${PS1_MODULES[$module]}" ]]; then
            continue
        fi

        "${PS1_MODULES[$module]}" out

        if [[ -n $out ]]; then
            if [[ -n "${PS1_PREFIXES[$module]:-}" ]]; then
                out="${PS1_PREFIXES[$module]}${out}"
            fi

            if [[ -n "${PS1_SUFFIXES[$module]:-}" ]]; then
                out="${out}${PS1_SUFFIXES[$module]}"
            fi

            output+="$out "
        fi

        unset out
    done

    # trim trailing spaces
    output="${output%" "}"
}

# -----------------------------------------------------------------------------
# command

ps1 () {
    case "$1" in
        "set-var")
            shift
            __ps1_set_var $@
            ;;

        "set-theme")
            shift
            __ps1_set_theme $@
            ;;

        *)
            echo "Invalid command: $command"
            return
            ;;
    esac
}

__ps1_set_var () {
    local var="$1"
    local val="$2"
    local accepted=("user" "host" "tty" "shell")

    if [[ -z "$var" ]]; then
        echo "Missing argument: variable" >&2
        return
    fi

    if [[ ! "${accepted[@]}" =~ "${var}" ]]; then
        echo "Invalid variable name: $var" >&2
        echo "Accepted variable names are: ${accepted[@]}" >&2
        return
    fi

    if [[ -z "$val" ]]; then
        read -p "${var^^}: " val
    fi

    declare -g "PS1_${var^^}"="$val"
}

__ps1_set_theme () {
    local theme="$1"

    # reset global variables
    PS1_LEFT=()
    PS1_RIGHT=()
    PS1_PREFIXES=()
    PS1_SUFFIXES=()
    PS1_NEWLINE=1
    PS1_NEWLINE_PROMPT=1

    IFS=':' read -ra dirs <<< "$PS1_PATH"
    for dir in "${dirs[@]}"; do
        if [[ -f "$dir/theme.d/$theme.sh" ]]; then
            source "$dir/theme.d/$theme.sh"
        fi
    done
}
