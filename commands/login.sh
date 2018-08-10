#!/bin/bash

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "no public key found. "
    exit 1;
fi;

echo $1 | grep '@' > /dev/null
if [ $? -ne 0 ]; then 
    username=root
    address=$1
    home=/root
else 
    username=`echo $1 | cut -d '@' -f 1`
    address=`echo $1 | cut -d '@' -f 2`
    home=/home/$username
fi

pubkey=`cat ~/.ssh/id_rsa.pub`
ssh $username@$address "\
    mkdir -p $home/.ssh; \
    [ ! -f $home/.ssh/authorized_keys ] && touch $home/.ssh/authorized_keys; \
    grep \"$pubkey\" $home/.ssh/authorized_keys > /dev/null 2>&1; \
    [ \$? -ne 0 ] && echo $pubkey > $home/.ssh/authorized_keys; \
    chmod 600 $home/.ssh/authorized_keys;"  > /dev/null 2>&1

ssh $username@$address
