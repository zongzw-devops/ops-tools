FROM centos:7
#docker build . -t vpn_container:latest

RUN yum update -y 

COPY ps-pulse-linux-9.1r2.0-b69-centos-rhel-64-bit-installer.rpm /root
RUN yum install -y glib-networking webkitgtk3 libgnome-keyring libproxy-gnome libproxy-mozjs libproxy
RUN yum install -y sudo sysvinit-tools vim net-tools
RUN rpm -ivh /root/ps-pulse-linux-9.1r2.0-b69-centos-rhel-64-bit-installer.rpm

ENTRYPOINT /usr/local/pulse/PulseClient_x86_64.sh -h ${HOST:-183.84.2.165} -u ${USERNAME} -p ${PASSWORD} -r Users -L 5
