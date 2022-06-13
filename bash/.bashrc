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

# -----------------------------------------------------------------------------
# HISTORY
# -----------------------------------------------------------------------------
#
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# -----------------------------------------------------------------------------
# EDITOR
# -----------------------------------------------------------------------------
#
export EDITOR='vim'
export VISUAL='vim'

# -----------------------------------------------------------------------------
# LESS
# -----------------------------------------------------------------------------
#
# set options
# see https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
export LESS='--quit-if-one-screen --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --tabs=4 --no-init --window=-4'
# or the short version
# export LESS='-F -i -J -M -R -W -x4 -X -z-4'

# set colors
# see https://wiki.archlinux.org/index.php/Color_output_in_console#less
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

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
    __git_complete g __git_main
fi

# Load MySQL bash completion and make them complete the 'my' alias
if [ -s /usr/share/bash-completion/completions/mysql ]; then
    . /usr/share/bash-completion/completions/mysql
    complete -o default -o nospace -F _mysql my
fi

# Load Docker bash completion and make them complete the 'd' alias
if [ -s /usr/share/bash-completion/completions/docker ]; then
    . /usr/share/bash-completion/completions/docker
    complete -o default -o nospace -F _docker d
fi

# -----------------------------------------------------------------------------
# APPARIX
# -----------------------------------------------------------------------------
#
if [ -f $HOME/.bash_apparix ]; then
    . $HOME/.bash_apparix
fi

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------
#
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# -----------------------------------------------------------------------------
# LS COLORS
# -----------------------------------------------------------------------------
#
if [ -f $HOME/.lscolors ]; then
    . $HOME/.lscolors
fi

# -----------------------------------------------------------------------------
# ANSIBLE
# -----------------------------------------------------------------------------
#
# disable cowsay for ansible
export ANSIBLE_NOCOWS=1

# autostart SSH agent on WSL environments
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval `ssh-agent -s`
    ssh-add
fi

# -----------------------------------------------------------------------------
# KEY BINDINGS
# -----------------------------------------------------------------------------
#
bind -x '"\C-g": default git status --short'
bind -x '"\C-gl": (default git log --decorate --oneline --color | head -n 5)'
bind -x '"\C-gd": default git diff --color=always'
bind -x '"\C-j": default jobs'
bind -x '"\C-h": (default history | tail -n 10)'

# -----------------------------------------------------------------------------
# WELCOME
# -----------------------------------------------------------------------------
#
function available {
    type "$1" &>/dev/null
}

if available fortune && available cowsay && available lolcat; then
    fortune | cowsay -f unipony-smaller | lolcat
fi

# silently update the dotfiles in background
if available git && [ -d $HOME/.dotfiles ] && [[ $- == *i* ]]; then
    (cd $HOME/.dotfiles && git pull >/dev/null 2>&1 &)
fi

# -----------------------------------------------------------------------------
# ANYTHING BELOW THAT LINE WAS ADDED BY A SCRIPT
# -----------------------------------------------------------------------------
#
