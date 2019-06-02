FROM ubuntu:xenial

RUN apt-get update \
    && apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev \
    bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev \
    libboost-test-dev libboost-thread-dev git ca-certificates curl libminiupnpc-dev autoconf libdb++-dev

WORKDIR /home/omnicore

RUN git clone https://github.com/OmniLayer/omnicore.git . \
    && git checkout v0.5.0

RUN ./autogen.sh \
    && ./configure --with-incompatible-bdb \
    && make \
    && ln ./src/omnicored /usr/local/bin/omnicored

CMD ["omnicored"]