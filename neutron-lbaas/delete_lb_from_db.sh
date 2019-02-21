#!/bin/bash 

mysqlpass=`grep connection=mysql /etc/neutron/neutron.conf | cut -d ':' -f 3 | cut -d '@' -f 1`

commands=""
for n in loadbalancer_statistics listeners members pools healthmonitors loadbalancers; do 
    commands="$commands delete from lbaas_$n;"
done
echo $commands
echo $commands | mysql -u neutron --password=$mysqlpass --database neutron

