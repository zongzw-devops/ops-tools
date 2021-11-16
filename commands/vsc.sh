#!/bin/bash 

target=.
if [ $# -eq 1 ]; then 
    echo $1
    target=$1
fi
open $target -a /Applications/Visual\ Studio\ Code\ -\ Insiders.app/
