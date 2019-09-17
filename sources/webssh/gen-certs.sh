certsdir=./certs
mkdir -p $certsdir
openssl req -newkey rsa:2048 -nodes -keyout $certsdir/domain.key -x509 \
    -days 365 -out $certsdir/domain.crt \
    -subj "/C=CN/ST=BJ/L=BJ/O=Example/OU=IT/CN=f5.com"
