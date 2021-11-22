#!/bin/bash

# $RANDOM = integer between 0 and 32767
# 4681 ~= 32767 / 7

if (( $RANDOM > 4681 )); then
    exit;
fi

cd ~/Workspace/bdelespierre/my-fortune

fortune >> FORTUNE.md

git add -A
git commit -m "$(shuf -n 3 /usr/share/dict/words | tr '\n' ' ')"
git push

