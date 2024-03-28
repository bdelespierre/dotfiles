#!/usr/bin/env bash
#
# Note: This theme is designed to work with the amazing JetBrains Mono font
# See https://www.jetbrains.com/lp/mono/ for installation instructions
#

# Left side
PS1_PREFIXES["user_host"]="${PS1_COLORS[bg_green]} "
PS1_SUFFIXES["user_host"]=" ${PS1_COLORS[bg_blue]}${PS1_COLORS[green]}${PS1_COLORS[default]}"

PS1_PREFIXES["time"]=""
PS1_SUFFIXES["time"]=" ${PS1_COLORS[bg_magenta]}${PS1_COLORS[blue]}${PS1_COLORS[default]}"

PS1_PREFIXES["tty_term_histnum"]="$"
PS1_SUFFIXES["tty_term_histnum"]=" ${PS1_COLORS[bg_yellow]}${PS1_COLORS[magenta]}${PS1_COLORS[default]}"

PS1_PREFIXES["pwd"]=""
PS1_SUFFIXES["pwd"]=" ${PS1_COLORS["bg_default"]}${PS1_COLORS[yellow]}${PS1_COLORS[default]}"

PS1_LEFT=("user_host" "time" "tty_term_histnum" "pwd")

# Right Side
PS1_PREFIXES["jobs"]="${PS1_COLORS[yellow]}${PS1_COLORS[default]}${PS1_COLORS[bg_yellow]} "
PS1_SUFFIXES["jobs"]=""

PS1_PREFIXES["git"]="${PS1_COLORS[cyan]}${PS1_COLORS[default]}${PS1_COLORS[bg_cyan]}  "
PS1_SUFFIXES["git"]=""

PS1_PREFIXES["timer"]="${PS1_COLORS[magenta]}${PS1_COLORS[default]}${PS1_COLORS[bg_magenta]} "
PS1_SUFFIXES["timer"]=" ${PS1_COLORS[bg_default]}"

PS1_RIGHT=("jobs" "git" "timer")
