#!/bin/bash

set -eux
cd /tmp

sudo apt-get install -y apparix stow git vim tmux

if [[ $* == *"--all"* ]]; then
    set -- "--recommend" "--gui" "--games" "--php" "--python" "--node"
fi

if [[ $* == *"--recommend"* ]]; then
    sudo apt install -y ncdu bat at htop
fi

if [[ $* == *"--gui"* ]]; then
    sudo apt install -y meld guake
fi

if [[ $* == *"--games"* ]]; then
    sudo apt install -y crawl crawl-tiles lolcat cowsay cmatrix
fi

if [[ $* == *"--php"* ]]; then
    sudo apt install -y php php-xml php-mbstring php-curl

    wget -O get-composer.php https://getcomposer.org/installer \
        && php get-composer.php \
        && chmod +x composer.phar \
        && sudo mv composer.phar /usr/local/bin/composer \
        && rm get-composer.php

    wget -O phive.phar https://phar.io/releases/phive.phar \
        && wget -O phive.phar.asc https://phar.io/releases/phive.phar.asc \
        && gpg --keyserver hkps://keys.openpgp.org --recv-keys 0x9D8A98B29B2D5D79 \
        && gpg --verify phive.phar.asc phive.phar \
        && chmod +x phive.phar \
        && sudo mv phive.phar /usr/local/bin/phive
fi

if [[ $* == *"--python"* ]]; then
    sudo apt install -y python3

    wget -O get-pip.py https://bootstrap.pypa.io/get-pip.py \
        && python3 get-pip.py \
        && rm get-pip.py
fi

if [[ $* == *"--node" ]]; then
    wget -O get-nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh \
        && bash get-nvm.sh \
        && rm get-nvm.sh
fi
