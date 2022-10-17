# docker build -t host-onboarding-ansible-env:latest .
FROM centos:7

ENV LANG=en_US.utf-8
ENV LC_ALL=en_US.utf-8

RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y wget curl tree git python3
RUN pip3 install --upgrade pip
RUN pip3 install ansible
RUN yum install -y sshpass
