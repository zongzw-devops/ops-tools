#!/bin/bash 

source ./keystonerc_admin

for n in `neutron lbaas-healthmonitor-list -f value -c id`; do neutron lbaas-healthmonitor-delete $n; done;
for n in `neutron lbaas-l7policy-list -f value -c id`; do neutron lbaas-l7policy-delete $n; done;
for n in `neutron lbaas-pool-list -f value -c id`; do neutron lbaas-pool-delete $n; done
for n in `neutron lbaas-listener-list -f value -c id`; do neutron lbaas-listener-delete $n; done;
for n in `neutron lbaas-loadbalancer-list -f value -c id`; do neutron lbaas-loadbalancer-delete $n; done;

