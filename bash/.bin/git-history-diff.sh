#!/bin/bash

A=${1:-master}
B=${1:-develop}

base=`git merge-base $A $B`

for branch in {$A,$B}; do
    files+=(`tempfile -s "_${branch}"`)
    git log --format="%s" $branch...$base | sort | grep -v "^Merge" > ${files[-1]}
done

echo ${files[@]} | xargs diff
