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
if ! __is_available composer; then
    curl https://getcomposer.org/installer -o get-composer.php
    php get-composer.php --quiet
    rm get-composer.php
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
if ! __is_available pip; then
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
fi
