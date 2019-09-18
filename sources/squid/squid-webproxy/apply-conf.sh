#!/bin/bash 

cdir=`cd $(dirname $0); pwd`
source $cdir/settings

# prepare the files 
if [ -z "$auth_required" ]; then 

cat << EOF > $cdir/squid.conf
acl all src 0.0.0.0/0
http_access allow all
http_port 3128
EOF

echo -n > $cdir/password

else 

cat << EOF > $cdir/squid.conf
auth_param basic program /usr/lib/squid3/basic_ncsa_auth /var/squid3/password
auth_param basic children 5
auth_param basic realm My Proxy Caching Domain
auth_param basic credentialsttl 2 hours
acl authaccess proxy_auth REQUIRED
http_access allow authaccess
http_port 3128
EOF

echo -n > $cdir/password
for n in $auth_required; do 
    user="`echo $n | cut -d ':' -f1`"
    pass="`echo $n | cut -d ':' -f2`"
    htpasswd -db $cdir/password $user $pass
done
fi

cat << EOF >> $cdir/squid.conf

cache_mem 2048 MB
cache_dir ufs /var/spool/squid3 10000 256 256

EOF
