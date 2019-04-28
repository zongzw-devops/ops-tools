#!/bin/bash 

if [ $# -ne 1 ]; then 
    echo "./$0 <org:branch>"
    exit 1
fi

org=`echo $1 | cut -d : -f 1`
branch=`echo $1 | cut -d : -f 2`
repo=`echo $(basename $0) | cut -d . -f 3`

cdir=$PWD
fldr=$org"_"$branch
(
    cd $cdir;
    mkdir -p $fldr;
    cd $fldr;
    if [ -d $repo ]; then rm -rf $repo; fi;
    git clone https://github.com/$org/$repo.git -b $branch

    cd $repo/app/waf
    ln -s $cdir/node_modules . 
)
