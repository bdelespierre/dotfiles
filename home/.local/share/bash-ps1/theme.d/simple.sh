#!/usr/bin/env bash

PS1_PREFIXES["git"]="${BASH_COLORS[dark_gray]}on${BASH_COLORS[reset]} "
PS1_PREFIXES["jobs"]="${BASH_COLORS[dark_gray]}jobs${BASH_COLORS[reset]} "
PS1_PREFIXES["pwd"]="${BASH_COLORS[dark_gray]}in${BASH_COLORS[reset]} "
PS1_LEFT=("git" "pwd" "jobs")
