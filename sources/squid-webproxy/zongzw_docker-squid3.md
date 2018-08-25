**This is a customized squid3 for personal use. **

# Usage: 

1.Pull it to local and run it: 
```
$ docker pull zongzw/docker-squid3:0.1
$ docker run -itd --name squid3 -p 3128:3128 zongzw/docker-squid3:0.1 

```
2.Update auth* user/password to yourself.
```
$ docker exec -it squid3 bash 
$ htpasswd -d /var/squid/password <your username>
        <Input your password> 

$ /usr/local/squid/sbin/squid -k reconfigure
```
_a. password should be 8-bits;_

_b. using -d tells htpasswd to use system's crypt function_

3.Set proxy in your browser. i.e. using switchysharp in Chrome.
