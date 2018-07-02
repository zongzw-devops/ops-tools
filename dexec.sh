#!/bin/bash 

docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

read -p "Container Name: " name

docker exec --env COLUMNS=65536 -it $name bash
