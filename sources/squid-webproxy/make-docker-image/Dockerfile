FROM ubuntu:14.04
RUN apt-get update
RUN apt-get -y install squid3=3.3.8-1ubuntu6.10
RUN apt-get -y install apache2-utils
ADD ./setup-passwd.sh /
ADD ./squid.conf /etc/squid3/

RUN chmod +x /setup-passwd.sh
RUN /setup-passwd.sh
RUN rm -rf /setup-passwd.sh

EXPOSE 3128

ENTRYPOINT /usr/sbin/squid3 -N
