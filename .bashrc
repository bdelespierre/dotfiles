# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# -----------------------------------------------------------------------------
# OPTIONS
# -----------------------------------------------------------------------------
#
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# -----------------------------------------------------------------------------
#
# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# for Vagrant
export MRD_NFS=true
export MRD_MEMORY="8192"
export MRD_EXEC_CAP="100"
export MRD_CPUS="4"

# -----------------------------------------------------------------------------
# HISTORY
# -----------------------------------------------------------------------------
#
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# -----------------------------------------------------------------------------
# PS1
# -----------------------------------------------------------------------------
#
PS1='\u@\h:\w\$ '

if [ -f "$HOME/.bash_ps1" ]; then
    source $HOME/.bash_ps1
fi

# -----------------------------------------------------------------------------
# COMPLETION
# -----------------------------------------------------------------------------
#
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Load Git bash completion and make them complete the 'g' alias
if [ -s /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
    complete -o default -o nospace -F _git g
fi

# -----------------------------------------------------------------------------
# APPARIX
# -----------------------------------------------------------------------------
#
if [ -f ~/.bash_apparix ]; then
    . ~/.bash_apparix
fi

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------
#
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# -----------------------------------------------------------------------------
# RANDOM STUFF
# -----------------------------------------------------------------------------
#
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -----------------------------------------------------------------------------
# WELCOME
# -----------------------------------------------------------------------------
#
function __is_available {
    type "$1" &> /dev/null
}

if __is_available fortune && __is_available cowsay; then
    fortune | cowsay
fi

