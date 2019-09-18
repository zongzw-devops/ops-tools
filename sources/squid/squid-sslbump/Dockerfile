# docker build . -t squid-bumpssl:latest
FROM centos:7

RUN yum update -y 
# Squid Cache: Version 3.5.20
RUN yum install -y squid httpd openssl vim wget 
RUN mkdir -p /etc/squid/ssl_cert
RUN chown squid:squid /etc/squid/ssl_cert
RUN chmod 700 /etc/squid/ssl_cert
RUN /usr/lib64/squid/ssl_crtd -c -s /var/lib/ssl_db -M 4MB
RUN chown squid:squid -R /var/lib/ssl_db
#RUN squid -z 
ENTRYPOINT while true; do sleep 1; done
#squid -z && squid -N
