FROM nginx:1.13.8
MAINTAINER Victor Pantoja
RUN apt update && apt install --force-yes -y openssl curl
RUN mkdir /etc/nginx/ssl
# RUN rm /etc/nginx/conf.d/*
RUN openssl req -x509 -nodes -days 500 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/portinarus.crt -subj "/C=AT/ST=./L=./O=./CN=."
#COPY portinarus.conf /etc/nginx/conf.d/

# installing filebeat
ENV FILEBEAT_VERSION 6.1.2

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-amd64.deb
RUN dpkg -i filebeat-${FILEBEAT_VERSION}-amd64.deb
RUN dpkg -i filebeat-${FILEBEAT_VERSION}-amd64.deb
RUN rm filebeat-${FILEBEAT_VERSION}-amd64.deb

RUN filebeat modules enable nginx

ADD filebeat.yml /etc/filebeat/filebeat.yml
RUN chmod 644 /etc/filebeat/filebeat.yml
