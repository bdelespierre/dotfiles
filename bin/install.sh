#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")/..

if [ $(pwd) = $HOME ]; then
    echo "$(basename $0): cannot expand, exiting." 1>&2
    exit 1;
fi

for file in `find . -path ./.git -prune -o -path ./bin -prune -o -type f -print | sed -e "s|./||"`; do
    dest="${HOME}/${file}"
    path="$(pwd)/${file}"
    dir=$(dirname $dest)

    echo "$file >> $dest"

    if [ ! -d $dir ]; then
        echo " - new directory ${dir}"
        mkdir -p $(dirname $dest)
    fi

    if [ -f $dest ] && [ ! -h $dest ]; then
        echo " - file exists, creating backup in ${dest}.bk"
        cp $dest "${dest}.bk" && rm $dest
    fi

    ln -fs $path $dest
done