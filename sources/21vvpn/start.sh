#!/bin/bash 

cdir=`cd $(dirname $0); pwd`
image_name=zongzw/f5-ps-21vvpn-centos:latest
container_name=VPNC

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

