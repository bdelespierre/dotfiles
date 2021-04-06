#!/bin/bash
VAR=$(grep $1 ${2:-.env} | xargs)
IFS="=" read -ra VAR <<< "$VAR"
echo ${VAR[1]}
