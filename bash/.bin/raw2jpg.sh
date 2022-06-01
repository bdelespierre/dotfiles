#!/usr/bin/bash

set -xe

echo "`ls -l *.{NEF,RAW,nef,raw} 2>/dev/null | wc -l` Files to convert"

find . -type f \( -iname "*.raw" -o -iname "*.nef" \) -exec sh -c 'darktable-cli {} ${0%.*}.jpg' {} \; -delete
