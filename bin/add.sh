#!/bin/bash

file=$(realpath $1)
root=$(realpath $(dirname "${BASH_SOURCE[0]}")/..)
dest="${root}/$(echo $file | sed -e "s|$HOME/||")"

echo "${file} >> ${dest}"

if [ -f $dest ]; then
    echo "$(basename $0): $dest already exists, exiting." 1>&2
    exit 1
fi

if [[ ! $file =~ ^$HOME ]]; then
    echo "$(basename $0): $1 is not in your home directory, exiting." 1>&2
    exit 1
fi

if [ $file = $HOME ]; then
    echo "$(basename $0): $1 is your home directory, exiting." 1>&2
    exit 1
fi

if [ -d $file ]; then
    dir=$file
    for file in `find $dir -type f | sort`; do
        ${BASH_SOURCE[0]} $file
    done
    exit 0
fi

if [ ! -f $file ]; then
    echo "$(basename $0): $1 does not exists" 1>&2
    exit 1
fi

if [ -h $file ]; then
    echo "$(basename $0): $1 is a link, exiting." 1>&2
    exit 1
fi

dir=$(dirname $dest)
if [ ! -d $dir ]; then
    echo " - new directory ${dir}"
    mkdir -p $dir
fi

mv $file $dest
ln -s $dest $file