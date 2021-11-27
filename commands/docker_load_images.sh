#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "$0 <source path>"
    exit 1
fi

source_dir=$1

(
    cd $source_dir
    for n in `ls`; do
        echo $n
        docker load -i $n
    done
)