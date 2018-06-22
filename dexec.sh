#!/bin/bash 

docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

read -p "Container Name: " name

docker exec -it $name bash

