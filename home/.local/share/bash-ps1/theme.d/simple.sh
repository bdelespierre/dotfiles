#!/usr/bin/env bash

PS1_PREFIXES["git"]="${PS1_COLORS[dark_gray]}on${PS1_COLORS[default]} "
PS1_PREFIXES["jobs"]="${PS1_COLORS[dark_gray]}jobs${PS1_COLORS[default]} "
PS1_PREFIXES["pwd"]="${PS1_COLORS[dark_gray]}in${PS1_COLORS[default]} "
PS1_LEFT=("git" "pwd" "jobs")
