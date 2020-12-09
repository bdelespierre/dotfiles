#!/bin/bash

# -----------------------------------------------------------------------------
# Sotfware
# -----------------------------------------------------------------------------
#
sudo apt-get install -y apparix stow php python3 git vim tmux

if [ $1 = "--recommend" ]; then
    sudo apt-get install -y meld guake crawl crawl-tiles
fi

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------
#
function __is_available {
    type "$1" &> /dev/null
}

# -----------------------------------------------------------------------------
# PHP & Composer Packages
# -----------------------------------------------------------------------------
#
function __install_composer {
    EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
        >&2 echo 'ERROR: Invalid installer checksum'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    rm composer-setup.php
}

if ! __is_available composer; then
    __install_composer
fi

composer global require phpunit/phpunit
#composer global require phing/phing
#composer global require phpdocumentor/phpdocumentor
composer global require sebastian/phpcpd
composer global require phploc/phploc
composer global require phpmd/phpmd
composer global require squizlabs/php_codesniffer

# -----------------------------------------------------------------------------
# Python & pip Packages
# -----------------------------------------------------------------------------
#
function __install_pip {
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
}

if ! __is_available pip; then
    __install_pip
fi
