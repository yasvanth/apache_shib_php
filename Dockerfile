FROM ubuntu:18.04

MAINTAINER Yasvanth Babu <yasvanth.babu@heanet.ie>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install curl apache2 gnupg2 lynx \
    ##### Add Switch repository to install shibboleth ubuntu package
    && curl -O http://pkg.switch.ch/switchaai/SWITCHaai-swdistrib.asc \
    && apt-key add SWITCHaai-swdistrib.asc \
    && echo 'deb http://pkg.switch.ch/switchaai/ubuntu bionic main' |  tee /etc/apt/sources.list.d/SWITCHaai-swdistrib.list > /dev/null \
    && apt-get -y update \
    && apt-get -y install --install-recommends shibboleth \
    && mkdir /etc/apache2/ssl /etc/shibboleth/sp-certs\
    && rm /etc/apache2/sites-enabled/* \
    && apt-get -y install \
         php \
         libapache2-mod-php  \
    && a2enmod ssl* proxy* request headers rewrite

COPY httpd-shibd-foreground.sh /

EXPOSE 80 443

ENTRYPOINT ["/httpd-shibd-foreground.sh"]
