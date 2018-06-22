#!/bin/bash

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "no public key found. "
    exit 1;
fi;

username=zong
pubkey=`cat ~/.ssh/id_rsa.pub`
ssh $username@$1 "\
    mkdir -p /home/$username/.ssh; \
    [ ! -f /home/$username/.ssh/authorized_keys ] && touch /home/$username/.ssh/authorized_keys; \
    grep \"$pubkey\" /home/$username/.ssh/authorized_keys > /dev/null 2>&1; \
    [ \$? -ne 0 ] && echo $pubkey > /home/$username/.ssh/authorized_keys; \
    chmod 600 /home/$username/.ssh/authorized_keys; \
    grep sudo\ su /home/$username/.bashrc > /dev/null 2>&1; \
    if [ \$? -ne 0 ]; then echo sudo su; echo sudo su >> /home/$username/.bashrc; fi"  > /dev/null 2>&1

ssh $username@$1
