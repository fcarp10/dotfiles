#!/bin/bash

cat extensions.txt | while read y
do
    [[ $y =~ ^#.* ]] && continue
    vscodium --install-extension $y
done