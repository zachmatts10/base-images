FROM aarch64/alpine:edge

LABEL io.resin.architecture="aarch64" io.resin.qemu.version="2.7.0-resin-rc3-arm"

COPY qemu-aarch64-static /usr/bin/qemu-aarch64-static

RUN apk add --update \
	bash \
	ca-certificates \
	dbus \
	findutils \
	openrc \
	tar \
	udev \
	&& rm -rf /var/cache/apk/*

# Config OpenRC
RUN sed -i '/tty/d' /etc/inittab
COPY rc.conf /etc/

COPY resin /etc/init.d/

RUN rc-update add resin default \
	&& rc-update add dbus default

COPY entry.sh /usr/bin/entry.sh
                  
ENTRYPOINT ["/usr/bin/entry.sh"]
