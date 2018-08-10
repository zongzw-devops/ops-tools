#!/bin/bash 

docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

read -p "Container Name: " name

docker exec --env COLUMNS=`tput cols` --env LINES=`tput lines` -it $name bash
