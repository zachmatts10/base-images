# AUTOGENERATED FILE
FROM resin/intel-quark-buildpack-deps:jessie

ENV NODE_VERSION 4.8.0

RUN curl -SLO "http://resin-packages.s3.amazonaws.com/node/v$NODE_VERSION/node-v$NODE_VERSION-linux-i386.tar.gz" \
	&& echo "beed194c151df32c98751b268d714112e5556f680a3a7308618a1cb524d2713f  node-v4.8.0-linux-i386.tar.gz" | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-i386.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-i386.tar.gz" \
	&& npm config set unsafe-perm true -g --unsafe-perm \
	&& rm -rf /tmp/*

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: http://docs.resin.io/deployment/dockerfile"]
ONBUILD RUN echo 'This repository is deprecated. Please check https://docs.resin.io/runtime/resin-base-images/ for information about Resin docker images.' 
