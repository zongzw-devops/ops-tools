#!/bin/bash 

docker-compose up -d --force-recreate
docker exec squid-proxy bash -c "squid -z" 
docker exec squid-proxy bash -c "squid" 
