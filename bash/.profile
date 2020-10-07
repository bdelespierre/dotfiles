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

# set PATH so it includes current directory and vendor/bin (for PHP projects)
PATH="$PATH:./:vendor/bin"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$PATH:$HOME/.bin"
fi

# set PATH so it includes composer's global binaries if it exists
if [ -d "$HOME/.composer/vendor/bin" ] ; then
    PATH="$PATH:$HOME/.composer/vendor/bin"
fi

# Add RVM to PATH for scripting
if [ -d "$HOME/.rvm/bin" ]; then
    PATH="$PATH:$HOME/.rvm/bin"
fi

export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/benjamin/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/benjamin/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/benjamin/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/benjamin/Downloads/google-cloud-sdk/completion.bash.inc'; fi
