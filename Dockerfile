FROM ubuntu:latest
LABEL maintainer="Felix Queißner docker@random-projects.net"

RUN    apt-get update -y \
    && apt-get -y upgrade \
    && apt-get install -y openssh-server rsync \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir /run/sshd

RUN adduser --shell /bin/sh --disabled-password upload

COPY ./entrypoint.sh ./sshd_config /

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
VOLUME /data   # expose r/w for storage
VOLUME /config # expose ro for configuration
