#!/bin/bash
set -x
mkdir /var/squid3
touch /var/squid3/password
for n in "zongzw:Az0@IBMC" "common:C0m2off_"; do
    user="`echo $n | cut -d ':' -f1`"
    pass="`echo $n | cut -d ':' -f2`"
    echo $user, $pass
    htpasswd -db /var/squid3/password $user $pass
done
