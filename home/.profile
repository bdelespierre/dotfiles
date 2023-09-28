# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# -----------------------------------------------------------------------------
# COLORS

declare -A BASH_COLORS
BASH_COLORS=(
    ["reset"]='\[\e[0m\]'        ["red"]='\[\e[31m\]'         ["light_red"]='\[\e[91m\]'
    ["bold"]='\[\e[1m\]'         ["green"]='\[\e[32m\]'       ["light_green"]='\[\e[92m\]'
    ["blink"]='\[\e[5m\]'        ["yellow"]='\[\e[33m\]'      ["light_yellow"]='\[\e[93m\]'
    ["white"]='\[\e[97m\]'       ["blue"]='\[\e[34m\]'        ["light_blue"]='\[\e[94m\]'
    ["light_gray"]='\[\e[37m\]'  ["magenta"]='\[\e[35m\]'     ["light_magenta"]='\[\e[95m\]'
    ["dark_gray"]='\[\e[90m\]'   ["cyan"]='\[\e[36m\]'        ["light_cyan"]='\[\e[96m\]'
    ["black"]='\[\e[30m\]'       ["default"]='\[\e[39m\]'
)

export BASH_COLORS

# -----------------------------------------------------------------------------
# PS1

PS1_PATH="$PS1_PATH:${XDG_DATA_HOME:-$HOME/.local/share}/bash-ps1"

# Windows equivalent of $HOME/.local/share
# is %LOCALAPPDATA% (e.g. C:\Users\Someone\Appdata\Local)
if [[ -n "$LOCALAPPDATA" ]]; then
    PS1_PATH="$PS1_PATH:$(cygpath "$LOCALAPPDATA")/bash-ps1"
fi

export PS1_PATH

# -----------------------------------------------------------------------------
# PATH

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
# BASHRC

# if running bash, include ~/.bashrc
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# -----------------------------------------------------------------------------
# NODE VERSION MANAGER

# load Node Version Manager (NVM)
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
# POSTGRESQL

# PostgreSQL passwords
if [ -f "$HOME/.pgpass" ]; then
    export PGPASSFILE="$HOME/.pgpass"
fi
