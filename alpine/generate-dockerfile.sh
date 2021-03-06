#!/bin/bash
set -e

repos='armhf i386 amd64 aarch64'
suites='edge 3.2 3.3 3.4 3.5'
QEMU_VERSION='2.7.0-resin-rc3-arm'
QEMU_SHA256='474263efd49ac9fe10240d0362c66411e124b5b80483bec7707efb9490c8c974'
QEMU_AARCH64_VERSION='2.7.0-resin-rc3-aarch64'
QEMU_AARCH64_SHA256='4e64ace5fcb82f55b3593c0721f58b1d3c48b2cb8a373c8cae5cfde3a3a71e46'

function version_le() { test "$(echo "$@" | tr " " "\n" | sort -V | tail -n 1)" != "$1"; }

# Download QEMU
curl -SLO https://github.com/resin-io/qemu/releases/download/qemu-$QEMU_VERSION/qemu-$QEMU_VERSION.tar.gz \
	&& echo "$QEMU_SHA256  qemu-$QEMU_VERSION.tar.gz" | sha256sum -c - \
	&& tar -xz --strip-components=1 -f qemu-$QEMU_VERSION.tar.gz
curl -SLO https://github.com/resin-io/qemu/releases/download/qemu-$QEMU_AARCH64_VERSION/qemu-$QEMU_AARCH64_VERSION.tar.gz \
	&& echo "$QEMU_AARCH64_SHA256  qemu-$QEMU_AARCH64_VERSION.tar.gz" | sha256sum -c - \
	&& tar -xz --strip-components=1 -f qemu-$QEMU_AARCH64_VERSION.tar.gz

chmod +x entry.sh qemu-arm-static resin qemu-aarch64-static
for repo in $repos; do
	case "$repo" in
	'armhf')
		baseImage='armhf/alpine'
		label="LABEL io.resin.architecture=\"armhf\" io.resin.qemu.version=\"$QEMU_VERSION\""
		qemu='COPY qemu-arm-static /usr/bin/qemu-arm-static'
	;;
	'i386')
		baseImage='i386/alpine'
		label="LABEL io.resin.architecture=\"i386\""
		qemu=''
	;;
	'amd64')
		baseImage='alpine'
		label="LABEL io.resin.architecture=\"amd64\""
		qemu=''
	;;
	'aarch64')
		baseImage='aarch64/alpine'
		label="LABEL io.resin.architecture=\"aarch64\" io.resin.qemu.version=\"$QEMU_VERSION\""
		qemu='COPY qemu-aarch64-static /usr/bin/qemu-aarch64-static'
	;;
	esac
	for suite in $suites; do
		# aarch64 images are available only with alpine linux 3.5 and higher.
		if [ $repo == "aarch64" ] && (version_le $suite "3.5"); then
			continue
		fi

		dockerfilePath=$repo/$suite
		mkdir -p $dockerfilePath

		sed -e s~#{FROM}~"$baseImage:$suite"~g \
			-e s~#{LABEL}~"$label"~g \
			-e s~#{QEMU}~"$qemu"~g Dockerfile.tpl > $dockerfilePath/Dockerfile
		cp entry.sh resin rc.conf $dockerfilePath/

		if [ $repo == "armhf" ]; then
			cp qemu-arm-static $dockerfilePath/
		fi
		if [ $repo == "aarch64" ]; then
			cp qemu-aarch64-static $dockerfilePath/
		fi
	done
done

rm -rf qemu-*
