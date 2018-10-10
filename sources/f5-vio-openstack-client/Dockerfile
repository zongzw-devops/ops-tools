FROM centos:7

RUN yum install -y epel-release
RUN yum install -y python-devel python-pip gcc openssl-devel wget vim openssl openssl-devel
RUN pip install --upgrade pip
RUN pip install --ignore-installed python-openstackclient ndg-httpsclient shade
COPY F5NET_Certificate-Bundle.p7b /
RUN openssl pkcs7 -inform DER -outform PEM -in F5NET_Certificate-Bundle.p7b -print_certs > f5-bundle.cer
RUN cat f5-bundle.cer >> `python -m requests.certs`

