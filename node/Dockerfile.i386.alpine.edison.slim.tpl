# AUTOGENERATED FILE
FROM #{FROM}

ENV NODE_VERSION #{NODE_VERSION}

# Install dependencies
apk add --no-cache libgcc libstdc++ libuv

RUN buildDeps='curl' \
	&& set -x \
	&& apk add --no-cache $buildDeps python \
	&& curl -SLO "#{BINARY_URL}" \
	&& echo "#{CHECKSUM}" | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-alpine-#{TARGET_ARCH}.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-alpine-#{TARGET_ARCH}.tar.gz" \
	&& apk del $buildDep \
	&& npm install mraa \
	&& npm cache clear \
	&& npm config set unsafe-perm true -g --unsafe-perm \
	&& rm -rf /tmp/*

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: http://docs.resin.io/#/pages/using/dockerfile.md"]
