#!/bin/bash 

cdir=`cd $(dirname $0); pwd`
image_name=zongzw/f5-ps-21vvpn-centos:latest
container_name=VPNC

[ $# -lt 1 ] && echo "$0 <user> [<password>]" && exit 1
user=$1
if [ $# -eq 2 ]; then 
    pass=$2
elif [ $# -eq 1 ]; then 
    read -s -p "Input Password: " pass
fi

docker rm --force $container_name
docker run \
    -itd \
    --name $container_name \
    -e USERNAME=$user -e PASSWORD=$pass \
    -v $cdir/squid.conf:/etc/squid/squid.conf \
    -p 3128:3128 -p 8888:8888 \
    --privileged \
    $image_name

