#!/usr/bin/env bash

PS1_PREFIXES["time"]="${BASH_COLORS[dark_gray]}at${BASH_COLORS[reset]} "
PS1_PREFIXES["git"]="${BASH_COLORS[dark_gray]}on${BASH_COLORS[reset]} "
PS1_PREFIXES["timer"]="${BASH_COLORS[dark_gray]}took${BASH_COLORS[reset]} "
PS1_PREFIXES["jobs"]="${BASH_COLORS[dark_gray]}jobs${BASH_COLORS[reset]} "
PS1_PREFIXES["pwd"]="${BASH_COLORS[dark_gray]}in${BASH_COLORS[reset]} "
PS1_LEFT=("user_host" "time" "tty_term_histnum" "pwd")
PS1_RIGHT=("jobs" "git" "timer")
