FROM resin/armv7hf-debian:wheezy

LABEL io.resin.device-type="raspberry-pi2"

RUN echo "deb http://archive.raspbian.org/raspbian wheezy main contrib non-free rpi firmware" >>  /etc/apt/sources.list \
	&& apt-key adv --keyserver pgp.mit.edu  --recv-key 0x9165938D90FDDD2E \
	&& echo "deb http://archive.raspberrypi.org/debian wheezy main" >>  /etc/apt/sources.list.d/raspi.list \
	&& apt-key adv --keyserver pgp.mit.edu  --recv-key 0x82B129927FA3303E

RUN apt-get update && apt-get install -y --no-install-recommends \
		less \
		libraspberrypi-bin \
		module-init-tools \
		nano \
		net-tools \
		ifupdown \
		iputils-ping \
		i2c-tools \
		usbutils \		
	&& rm -rf /var/lib/apt/lists/*
