# docker build . -t zongzw/webssh:1.0.0

FROM python:latest
RUN pip install webssh
ENTRYPOINT \
    if [ -f /certs/domain.crt ]; then \
        wssh --certfile=/certs/domain.crt --keyfile=certs/domain.key; \
    else \
        wssh; \
    fi; 
