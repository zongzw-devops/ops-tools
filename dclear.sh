#!/bin/bash 

docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

read -p "Container Name: " name

docker stop $name
docker rm $name
