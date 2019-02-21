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

for n in {1..2}; do 
    lbname=lbaas-$n
    lsname=listener-$n
    plname=pool-$n
    mbname=member-$n
    mnname=monitor-$n

    neutron lbaas-loadbalancer-create $subnetid --name $lbname
    if [ $? -ne 0 ]; then 
        echo "create loadbalancer is failed."
        continue
    fi

    lbIsComplete
    if [ $? -ne 0 ]; then 
        continue
    fi

    lbid=`neutron lbaas-loadbalancer-list -c id -c name | grep $lbname | cut -d '|' -f2 | tr -d ' '`
    neutron lbaas-listener-create --loadbalancer $lbid --protocol HTTP --protocol-port 80 --name $lsname
    if [ $? -ne 0 ]; then 
        echo "create listener is failed."
        continue
    fi

    lbIsComplete
    if [ $? -ne 0 ]; then 
        continue
    fi

    lsid=`neutron lbaas-listener-list -c id -c name | grep $lsname | cut -d '|' -f2 | tr -d ' '`
    neutron lbaas-pool-create --lb-algorithm ROUND_ROBIN --protocol HTTP --listener $lsid --name $plname
    if [ $? -ne 0 ]; then 
        echo "create pool is failed."
        continue
    fi

    lbIsComplete
    if [ $? -ne 0 ]; then 
        continue
    fi

    plid=`neutron lbaas-pool-list -c id -c name | grep $plname | cut -d '|' -f2 | tr -d ' '`
    neutron lbaas-member-create --subnet $subnetid --address 10.0.0.146 --protocol-port 80 $plid
    if [ $? -ne 0 ]; then 
        echo "create member is failed."
        continue
    fi

    lbIsComplete
    if [ $? -ne 0 ]; then 
        continue
    fi

    neutron lbaas-healthmonitor-create --delay 1 --max-retries 3 --timeout 3 --type PING --pool $plid
    if [ $? -ne 0 ]; then 
        echo "create healthmonitor is failed."
        continue
    fi

    lbIsComplete
    if [ $? -ne 0 ]; then 
        continue
    fi


        
done



