# AUTOGENERATED FILE
FROM resin/zc702-zynq7-alpine-buildpack-deps:edge

ENV NODE_VERSION 6.10.0

# Install dependencies
RUN apk add --no-cache libgcc libstdc++ libuv

RUN curl -SLO "http://resin-packages.s3.amazonaws.com/node/v$NODE_VERSION/node-v$NODE_VERSION-linux-alpine-armhf.tar.gz" \
	&& echo "aa39e6fa304836c03e3581eda328f8e000edb1925433bb5cc4e8053d9aeb6fbe  node-v6.10.0-linux-alpine-armhf.tar.gz" | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-alpine-armhf.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-alpine-armhf.tar.gz" \
	&& npm config set unsafe-perm true -g --unsafe-perm \
	&& rm -rf /tmp/*

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: http://docs.resin.io/deployment/dockerfile"]
ONBUILD RUN echo 'This repository is deprecated. Please check https://docs.resin.io/runtime/resin-base-images/ for information about Resin docker images.' 
