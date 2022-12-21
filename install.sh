#!/bin/bash
#
# Usage (Ubuntu/Debian):
# wget -O - https://raw.githubusercontent.com/bdelespierre/dotfiles/master/install.sh | bash
#
set -eu

# install packages
sudo apt update
sudo apt install -y git stow tmux vim

# install git-delta
wget -O delta.deb https://github.com/dandavison/delta/releases/download/0.15.1/git-delta_0.15.1_amd64.deb
sudo dpkg -i delta.deb
rm -fv delta.deb

# clone the dotfiles
cd "$HOME"
git clone https://github.com/bdelespierre/dotfiles.git .dotfiles
cd .dotfiles

# backup existing dotfiles in $HOME
for FILE in home/{.,}*; do
    FILE="$HOME/$(basename $FILE)"
    [[ -f "$FILE" ]] && mv -fv "$FILE" "$FILE.backup"
done

# stow dotfiles
stow home

echo -e "Dotfiles successfully installed!"
echo -e "Run \e[0;32mexec bash\e[0m to reload bash."
