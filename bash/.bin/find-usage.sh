#!/bin/bash
git grep -C2 -p -E "(-[>]|::)$1\("
