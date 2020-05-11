Used to setup a basic webproxy for self use. 

Usage: 

1. Edit settings file: 
> * container_name: the docker container name; 
> * auth_required: 
>>> a. Can be left empty and removed, if that, no password will there be when connecting to webproxy;

>>> b. If configured, the format for them should be "\<user1>:\<pass1> \<user2>:\<pass2> ..."

2. Run run_webproxy.sh to start docker container
3. Configure your web browser to use this http proxy.

Note: if 'htpasswd' command not found, try installing httpd or apache2. 
