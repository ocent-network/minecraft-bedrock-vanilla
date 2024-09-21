FROM debian:buster

MAINTAINER Ocent, <i@ocent.net>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

# Install OS deps
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get -y install curl ca-certificates openssl git tar sqlite fontconfig tzdata iproute2 locales rsync \
    && apt-get -y install libstdc++6 lib32stdc++6 tar curl iproute2 openssl \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -d /home/container -m container

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
