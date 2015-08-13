# image name lzh/nova-consoleauth:kilo
FROM registry.lzh.site:5000/lzh/openstackbase:kilo

MAINTAINER Zuhui Liu penguin_tux@live.com

ENV BASE_VERSION 2015-07-14
ENV OPENSTACK_VERSION kilo


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -t jessie-backports install nova-consoleauth -y
RUN apt-get clean

RUN env --unset=DEBIAN_FRONTEND

RUN cp -rp /etc/nova/ /nova
RUN rm -rf /var/log/nova/*

VOLUME ["/etc/nova"]
VOLUME ["/var/log/nova"]

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ADD nova-consoleauth.conf /etc/supervisor/conf.d/nova-consoleauth.conf

ENTRYPOINT ["/usr/bin/entrypoint.sh"]