FROM ubuntu:bionic
LABEL vendor="cedrickoka/transmission" maintainer="okacedrick@gmail.com" version="1.0.0"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -y nano software-properties-common \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN add-apt-repository ppa:transmissionbt/ppa \
	&& apt-get install -y transmission-cli transmission-common transmission-daemon \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY settings.json /var/lib/transmission-daemon/info/settings.json

ARG TRANSMISSION_RPC_USERNAME=transmission
ARG TRANSMISSION_RPC_PASSWORD=transmission
ARG TRANSMISSION_PEER_PORT=51413
ARG TRANSMISSION_ALLOWED_IP_ADDRESSES=*

ENV RPC_USERNAME=$TRANSMISSION_RPC_USERNAME
ENV RPC_PASSWORD=$TRANSMISSION_RPC_PASSWORD
ENV PEER_PORT=$TRANSMISSION_PEER_PORT
ENV ALLOWED_IP_ADDRESSES=$TRANSMISSION_ALLOWED_IP_ADDRESSES

EXPOSE 9091

STOPSIGNAL SIGTERM

ADD entrypoint.sh /entrypoint.sh
RUN chmod 0777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
