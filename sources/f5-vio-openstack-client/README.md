## Usage of f5-vio-openstack-client

The image can be used to connect any openstack host, what's special is it has been injected with F5CA-bundle, which can connect to f5 vio openstack environment. 

To run the image, please use 

>```-v path/to/openstackrc/file:/root/rcfile```

 to involve the rc file into the container.

More convinient way to run docker image can be **dstart.sh, dexec.sh dclear.sh** defined in *https://github.com/zongzw/self-ops-tools/tree/master/commands*