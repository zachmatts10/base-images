# AUTOGENERATED FILE
FROM resin/beaglebone-green-fedora-buildpack-deps:latest

ENV NODE_VERSION 6.6.0

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-armv7l.tar.gz" \
	&& echo "e4dc3295f6602b0f4cd3433a6e520294743e2c342692b4fad388d33910cdd465  node-v6.6.0-linux-armv7l.tar.gz" | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-armv7l.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-armv7l.tar.gz" \
	&& npm config set unsafe-perm true -g --unsafe-perm \
	&& rm -rf /tmp/*

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: http://docs.resin.io/deployment/dockerfile"]
