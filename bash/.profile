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
PATH="$PATH:./:vendor/bin:./node_modules/.bin/"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$PATH:$HOME/.bin"
fi

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

# Add .config/gridky/bin to PATH
if [ -d "$HOME/.config/gridky/bin" ]; then
    PATH="$PATH:$HOME/.config/gridky/bin"
fi

# Add Android Studio path
if [ -d "/opt/android-studio/bin" ]; then
    PATH="$PATH:/opt/android-studio/bin"
fi

# Add Flutter path
if [ -d "$HOME/snap/flutter/common/flutter/bin" ]; then
    PATH="$PATH:/snap/flutter/common/flutter/bin"
fi

# install NVM
# wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# see https://github.com/nvm-sh/nvm

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

# Path built, export it
export PATH
