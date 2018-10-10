#!/bin/bash 

cdir=$(cd `dirname $0`; pwd)

image_name=f5-vio-openstack-client
docker build $cdir -t $image_name

