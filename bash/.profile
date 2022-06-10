# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash include .bashrc if it exists
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# set PATH so it includes current directory
# and vendor/bin (for PHP projects)
# and ./node_modules/.bin/ (for NPM projects)
PATH="$PATH:./:vendor/bin:./node_modules/.bin"

# set PATH so it includes composer's global binaries if it exists
if [ -d "$HOME/.composer/vendor/bin" ] ; then
    PATH="$PATH:$HOME/.composer/vendor/bin"
fi

# Composer 2 installs its binbaries into .config
if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
    PATH="$PATH:$HOME/.config/composer/vendor/bin"
fi

# Add RVM to PATH for scripting
if [ -d "$HOME/.rvm/bin" ]; then
    PATH="$PATH:$HOME/.rvm/bin"
fi

# Add .local/bin to PATH for python modules
if [ -d "$HOME/.local/bin" ]; then
    PATH="$PATH:$HOME/.local/bin"
fi

# Path built, export it
export PATH

# load Node Version Manager (NVM)
if [ -d "$HOME/.nvm" ]; then
    # Add NVM path
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

# PostgreSQL passwords
if [ -f "$HOME/.pgpass" ]; then
    export PGPASSFILE="$HOME/.pgpass"
fi
