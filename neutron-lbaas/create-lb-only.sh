#!/bin/bash 

source keystonerc_admin
subnetname=f5_test_subnet

subnetid=`neutron subnet-list -c id -c name | grep $subnetname | cut -d '|' -f 2 | tr -d ' '`
if [ -z "$subnetid" ]; then 
    echo "not found subnet: $subnetname"
    exit 1
fi
echo $subnetname: $subnetid

function lbIsComplete() {
    timeout=15
    while [ $timeout -gt 0 ]; do 
        neutron lbaas-loadbalancer-list | grep $lbname | grep PENDING_
        if [ $? -eq 0 ]; then 
            echo "waiting for complete."
            sleep 1
        else
            echo "pending status is over."
            return 0
        fi

        timeout=$(($timeout - 1))
    done

    if [ $timeout -eq 0 ]; then 
        echo "time out for this action."
        return 1
    fi
    
}

for n in {1..1}; do 
    lbname=lbaas-$n

    neutron lbaas-loadbalancer-create $subnetid --name $lbname
    if [ $? -ne 0 ]; then 
        echo "create loadbalancer is failed."
        continue
    fi

    lbIsComplete
    if [ $? -ne 0 ]; then 
        continue
    fi
done

