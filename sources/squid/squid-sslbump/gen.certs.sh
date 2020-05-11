#!/bin/bash 

openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -extensions v3_ca -keyout ./myCA.pem  -out ./myCA.pem -subj "/C=CN/ST=Beijing/L=Beijing/O=f5china/OU=pd-21/CN=ca-int@f5.test.com/emailAddress=zongzhaowei-2002@163.com"
