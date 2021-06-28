FROM alpine:3.14.0
LABEL vendor="cedrickoka/transmission" maintainer="okacedrick@gmail.com" version="1.0.0"

WORKDIR /opt/transmission

## Install system dependencies
RUN apk update && \
	apk add --no-cache \
		transmission-daemon=3.00-r3

ENV LOG_DIR=/dev/stdout
ENV CONFIG_DIR=/var/lib/transmission-daemon/info
ENV RPC_USERNAME=transmission
ENV RPC_PASSWORD=transmission
ENV ALLOWED_IP_ADDRESSES=*
ENV PEER_PORT=51413

COPY settings.json "$CONFIG_DIR/settings.json"
COPY docker-transmission-entrypoint.sh /usr/local/bin/docker-transmission-entrypoint.sh

RUN chmod a+x /usr/local/bin/docker-transmission-entrypoint.sh

EXPOSE 9091 51413

STOPSIGNAL SIGTERM

ENTRYPOINT ["docker-transmission-entrypoint.sh"]
CMD transmission-daemon -f --username "$RPC_USERNAME" --password "$RPC_PASSWORD" --peerport $PEER_PORT --allowed "$ALLOWED_IP_ADDRESSES" --config-dir "$CONFIG_DIR" --logfile "$LOG_DIR"
