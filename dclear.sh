#!/bin/bash 

docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

read -p "Container Names: " names

docker stop $names
docker rm $names

