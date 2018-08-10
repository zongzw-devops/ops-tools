docker run --name squid -d --restart=always \
  --publish 3128:3128 \
  sameersbn/squid:3.3.8-23
