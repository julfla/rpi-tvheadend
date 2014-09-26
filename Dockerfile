FROM cellofellow/rpi-arch
MAINTAINER romainf

RUN pacman --noconfirm -Sy base-devel git avahi nss-mdns openssl python2 && pacman --noconfirm -Sc

# Compile tvheadend from master
RUN cd /tmp && git clone https://github.com/tvheadend/tvheadend.git && cd /tmp/tvheadend && ./configure && make && make install && cd / && rm -rf /tmp/tvheadend

# Config directory, should be persisted
VOLUME ["/config"]

# Records directory, for video recorder and timeshif
VOLUME ["/records"]

# HTTP port (web interface)
EXPOSE 9981

# HTSP port (stream)
EXPOSE 9982

ENTRYPOINT ["/usr/local/bin/tvheadend"]
CMD ["-c", "/config"]
