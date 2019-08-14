#!/bin/bash 

cdir=`cd $(dirname $0); pwd`
image_name=f5-ps-21vvpn:latest
container_name=VPNC

docker build $cdir -f $cdir/Dockerfile -t $image_name
[ $# -ne 2 ] && echo "$0 <user> <password>" && exit 1
user=$1
pass=$2

docker rm --force $container_name
docker run \
    -itd \
    --name $container_name \
    -e USERNAME=$user -e PASSWORD=$pass \
    --privileged \
    $image_name

