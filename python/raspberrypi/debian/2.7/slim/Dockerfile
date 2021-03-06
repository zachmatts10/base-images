FROM resin/rpi-raspbian:jessie

# remove several traces of debian python
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# install python dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		libsqlite3-0 \
		libssl1.0.0 \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get -y autoremove

# key 63C7CC90: public key "Simon McVittie <smcv@pseudorandom.co.uk>" imported
# key 3372DCFA: public key "Donald Stufft (dstufft) <donald@stufft.io>" imported
RUN gpg --keyserver keyring.debian.org --recv-keys 4DE8FF2A63C7CC90 \
	&& gpg --keyserver pgp.mit.edu  --recv-key 6E3CBCE93372DCFA \
	&& gpg --keyserver pgp.mit.edu --recv-keys 0x52a43a1e4b77b059

ENV PYTHON_VERSION 2.7.12

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 9.0.1
ENV PYTHON_PIP_SHA256 d03fabbc4fbf2fbfc2f97307960aef2b3ca4c880ecda993dcc35957e33d7cd76

ENV SETUPTOOLS_SHA256 197b0c1e69a29c3a9eab446ef0a1884890da0c9784b8f556d0c64071819991d6
ENV SETUPTOOLS_VERSION 28.6.1

RUN set -x \
	&& buildDeps=' \
		curl \
	' \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& curl -SLO "http://resin-packages.s3.amazonaws.com/python/v$PYTHON_VERSION/Python-$PYTHON_VERSION.linux-armv6hf.tar.gz" \
	&& echo "f02d33d51a37e6319718a6ebef5f182bbff26007717f93fefb5538fb8e75a923  Python-2.7.12.linux-armv6hf.tar.gz" | sha256sum -c - \
	&& tar -xzf "Python-$PYTHON_VERSION.linux-armv6hf.tar.gz" --strip-components=1 \
	&& rm -rf "Python-$PYTHON_VERSION.linux-armv6hf.tar.gz" \
	&& ldconfig \
	&& mkdir -p /usr/src/python/setuptools \
	&& curl -SLO https://github.com/pypa/setuptools/archive/v$SETUPTOOLS_VERSION.tar.gz \
	&& echo "$SETUPTOOLS_SHA256  v$SETUPTOOLS_VERSION.tar.gz" > v$SETUPTOOLS_VERSION.tar.gz.sha256sum \
	&& sha256sum -c v$SETUPTOOLS_VERSION.tar.gz.sha256sum \
	&& tar -xzC /usr/src/python/setuptools --strip-components=1 -f v$SETUPTOOLS_VERSION.tar.gz \
	&& rm -rf v$SETUPTOOLS_VERSION.tar.gz* \
	&& cd /usr/src/python/setuptools \
	&& python2 bootstrap.py \
	&& python2 easy_install.py . \
	&& mkdir -p /usr/src/python/pip \
	&& curl -SL "https://github.com/pypa/pip/archive/$PYTHON_PIP_VERSION.tar.gz" -o pip.tar.gz \
	&& echo "$PYTHON_PIP_SHA256  pip.tar.gz" > pip.tar.gz.sha256sum \
	&& sha256sum -c pip.tar.gz.sha256sum \
	&& tar -xzC /usr/src/python/pip --strip-components=1 -f pip.tar.gz \
	&& rm pip.tar.gz* \
	&& cd /usr/src/python/pip \
	&& python2 setup.py install \
	&& cd .. \
	&& find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& cd / \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -rf /usr/src/python ~/.cache

# install "virtualenv", since the vast majority of users of this image will want it
RUN pip install --no-cache-dir virtualenv

# install dbus-python dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		libdbus-1-dev \
		libdbus-glib-1-dev \
	&& rm -rf /var/lib/apt/lists/*

ENV PYTHON_DBUS_VERSION 1.2.4

# install dbus-python
RUN set -x \
	&& buildDeps=' \
		curl \
		build-essential \
	' \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/dbus-python \
	&& curl -SL "http://dbus.freedesktop.org/releases/dbus-python/dbus-python-$PYTHON_DBUS_VERSION.tar.gz" -o dbus-python.tar.gz \
	&& curl -SL "http://dbus.freedesktop.org/releases/dbus-python/dbus-python-$PYTHON_DBUS_VERSION.tar.gz.asc" -o dbus-python.tar.gz.asc \
	&& gpg --verify dbus-python.tar.gz.asc \
	&& tar -xzC /usr/src/dbus-python --strip-components=1 -f dbus-python.tar.gz \
	&& rm dbus-python.tar.gz* \
	&& cd /usr/src/dbus-python \
	&& PYTHON=python2.7 ./configure \
	&& make -j$(nproc) \
	&& make install -j$(nproc) \
	&& cd / \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -rf /usr/src/dbus-python

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: http://docs.resin.io/deployment/dockerfile"]
ENV PYTHONPATH /usr/lib/python2.7/dist-packages:/usr/lib/python2.7/site-packages:$PYTHONPATH
ONBUILD RUN echo 'This repository is deprecated. Please check https://docs.resin.io/runtime/resin-base-images/ for information about Resin docker images.' 
