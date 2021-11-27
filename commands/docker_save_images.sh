#!/bin/bash

set -e
if [ $# -ne 1 ]; then
    echo "$0 <target path>"
    exit 1
fi

target_dir=$1
if [ ! -d $target_dir ]; then
    echo "$target_dir doesn't exist. make it."
    mkdir -p $target_dir
fi
empty=`ls $target_dir`
if [ x"$empty" != x ]; then
    echo "$target_dir not empty, quit."
    exit 1
fi

images=`docker images --format "{{.Repository}}:{{.Tag}}"`
for n in $images; do
    echo $n
    name=`echo $n | base64 -w0`
    docker save $n -o $target_dir/$name
done