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
export HISTCONTROL=ignoreboth:erasedups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

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
# lessfile is a nice incantation that lets less open up tar and gz files
# and so on and show you what's inside.
if command -v lessfile &>/dev/null; then
    eval "$(SHELL=/bin/sh lessfile)"
    # this sets LESSOPEN and will pick up on ~/.lessfilter.
else
    # fall back to do the best we can.
    export LESSOPEN="| ~/.lessfilter %s"
fi

# if any syntax highlighters are available, use them.
# pygmentize does more, but source-highlight is still good.
if command -v pygmentize &>/dev/null; then
    export LESSCOLOURIZER="pygmentize -f terminal"
elif command -v source-highlight &>/dev/null; then
    export LESSCOLOURIZER="source-highlight --failsafe --infer-lang -f esc --style-file=esc.style -i"
fi

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
fi

if type __git_complete &>/dev/null; then
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

# This is only useful on Windows environments
if [ -f ~/.usr/share/bash-completion/completions/ssh ] && test ~/.usr/share/bash-completion/completions/ssh; then
    . ~/.usr/share/bash-completion/completions/ssh
fi

# Load PS1 bash completion
if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/ps1" ]; then
    . "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/ps1"
    complete -o default -o nospace -F _ps1 ps1
fi

# Bash completion autoloader
if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion.d" ]; then
    for COMPFILE in "${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion.d"/*; do
        . "$COMPFILE"
        complete -o default -o nospace -F "_${COMPFILE##*/}" "${COMPFILE##*/}"
    done
fi

# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# -----------------------------------------------------------------------------
#
if [ -f "$HOME/.env" ]; then
    . "$HOME/.env"
elif [ -f "$HOME/.env.dist" ]; then
    . "$HOME/.env.dist"
fi

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------
#
# set PATH so it includes current directory
# and ./vendor/bin (for PHP projects)
# and ./node_modules/.bin/ (for NPM projects)
PATH="$PATH:./:./vendor/bin:./node_modules/.bin"

# set PATH so it includes composer's global binaries if it exists
if [ -d "$HOME/.composer/vendor/bin" ] ; then
    PATH="$PATH:$HOME/.composer/vendor/bin"
fi

# Composer 2 installs its binbaries into ~/.config
if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
    PATH="$PATH:$HOME/.config/composer/vendor/bin"
fi

# add RVM (Ruby) to PATH for scripting
if [ -d "$HOME/.rvm/bin" ]; then
    PATH="$PATH:$HOME/.rvm/bin"
fi

# add ~/.local/bin to PATH for python modules
if [ -d "$HOME/.local/bin" ]; then
    PATH="$PATH:$HOME/.local/bin"
fi

# path built, export it!
export PATH

# -----------------------------------------------------------------------------
# COLORS
# -----------------------------------------------------------------------------
#
declare -A PS1_COLORS
PS1_COLORS=(
    # Special
    ["reset"]='\[\e[0m\]'
    ["bold"]='\[\e[1m\]'
    ["blink"]='\[\e[5m\]'

    # Foreground
    ["default"]='\[\e[39m\]'        ["red"]='\[\e[31m\]'            ["light_red"]='\[\e[91m\]'
    ["white"]='\[\e[97m\]'          ["green"]='\[\e[32m\]'          ["light_green"]='\[\e[92m\]'
    ["black"]='\[\e[30m\]'          ["yellow"]='\[\e[33m\]'         ["light_yellow"]='\[\e[93m\]'
                                    ["blue"]='\[\e[34m\]'           ["light_blue"]='\[\e[94m\]'
                                    ["magenta"]='\[\e[35m\]'        ["light_magenta"]='\[\e[95m\]'
                                    ["cyan"]='\[\e[36m\]'           ["light_cyan"]='\[\e[96m\]'
                                    ["dark_gray"]='\[\e[90m\]'      ["light_gray"]='\[\e[37m\]'

    # Background
    ["bg_default"]='\[\e[49m\]'     ["bg_red"]='\[\e[41m\]'         ["bg_light_red"]='\[\e[101m\]'
    ["bg_white"]='\[\e[107m\]'      ["bg_green"]='\[\e[42m\]'       ["bg_light_green"]='\[\e[102m\]'
    ["bg_black"]='\[\e[40m\]'       ["bg_yellow"]='\[\e[43m\]'      ["bg_light_yellow"]='\[\e[103m\]'
                                    ["bg_blue"]='\[\e[44m\]'        ["bg_light_blue"]='\[\e[104m\]'
                                    ["bg_magenta"]='\[\e[45m\]'     ["bg_light_magenta"]='\[\e[105m\]'
                                    ["bg_cyan"]='\[\e[46m\]'        ["bg_light_cyan"]='\[\e[106m\]'
                                    ["bg_dark gray"]='\[\e[100m\]'  ["bg_light_gray"]='\[\e[47m\]'
)

export PS1_COLORS

# -----------------------------------------------------------------------------
# PS1
# -----------------------------------------------------------------------------
#
PS1_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/bash-ps1"

# Windows equivalent of $HOME/.local/share
# is %LOCALAPPDATA% (e.g. C:\Users\Someone\Appdata\Local)
if [[ -n "$LOCALAPPDATA" ]]; then
    PS1_PATH="$PS1_PATH:$(cygpath "$LOCALAPPDATA")/bash-ps1"
fi

export PS1_PATH

if [ -f "$HOME/.local/bin/ps1.sh" ]; then
    . "$HOME/.local/bin/ps1.sh"

    # auto-switch layout for VSCode console
    if [[ "$TERM_PROGRAM" = "vscode" ]]
        then ps1 set-theme vscode
        else ps1 set-theme default
    fi

    # change hostname on my Klee machine
    if [[ "$HOSTNAME" = KCI-* ]]
        then ps1 set-var host "klee"
    fi

    # change hostname on my Mention machine
    if [[ "$HOSTNAME" = mention-* ]]
        then ps1 set-var host "mention"
    fi
fi

# -----------------------------------------------------------------------------
# APPARIX
# -----------------------------------------------------------------------------
#
if [ -f "$HOME/.bourne_apparix" ]; then
    . "$HOME/.bourne_apparix" &> /dev/null
fi


# -----------------------------------------------------------------------------
# POSTGRESQL
# -----------------------------------------------------------------------------
#
if [ -f "$HOME/.pgpass" ]; then
    export PGPASSFILE="$HOME/.pgpass"
fi

# -----------------------------------------------------------------------------
# NODE VERSION MANAGER
# -----------------------------------------------------------------------------
#
if [ -d "$HOME/.nvm" ]; then
    # add NVM path
    export NVM_DIR="$HOME/.nvm"

    # load NVM
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh"
    fi

    # load NVM bash completion
    if [ -s "$NVM_DIR/bash_completion" ]; then
        source "$NVM_DIR/bash_completion"
    fi
fi

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------
#
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# -----------------------------------------------------------------------------
# ANSIBLE
# -----------------------------------------------------------------------------
#
export ANSIBLE_NOCOWS=1

# -----------------------------------------------------------------------------
# KEY BINDINGS
# -----------------------------------------------------------------------------
#
bind -x '"\eg": default git -c color.status=always status --short'
bind -x '"\eh": (default history | tail -n 10)'
bind -x '"\ej": default jobs'
bind -x '"\el": default ls'
