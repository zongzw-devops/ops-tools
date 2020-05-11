#!/bin/bash 

if [ $# -eq 0 ]; then 
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
    read -p "Container Name: " name
else
    name=$1
fi

docker exec --env COLUMNS=`tput cols` --env LINES=`tput lines` -it $name bash
