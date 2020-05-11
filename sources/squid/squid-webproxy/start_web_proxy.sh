#!/bin/bash 

export SQUIDHOME=`cd $(dirname $0); pwd`

(
	cd $SQUIDHOME
	./apply-conf.sh
	mkdir -p logs
	mkdir -p cachedir
)

docker-compose -f $SQUIDHOME/docker-compose.yml up -d --force-recreate
