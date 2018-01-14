FROM nginx:1.13.8-alpine
MAINTAINER Victor Pantoja
RUN apk add --update openssl
RUN mkdir /etc/nginx/ssl
RUN rm /etc/nginx/conf.d/*
RUN openssl req -x509 -nodes -days 500 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/portinarus.crt -subj "/C=AT/ST=./L=./O=./CN=."
COPY portinarus.conf /etc/nginx/conf.d/
