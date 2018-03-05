FROM debian:jessie
MAINTAINER Anton Bogdanovich <anton@bogdanovich.co>

ENV ZCASH_USER=zcash \
    ZCASH_HOME=/zcash \
    ZCASH_RPC_USER=zcash \
    ZCASH_RPC_PASSWORD= \
    ZCASH_RPC_PORT=8232 \
    ZCASH_GEN=0 \
    ZCASH_GEN_PROC_LIMIT=-1 \
    ZCASH_TESTNET=1 \
    ZCASH_ADDNODE=betatestnet.z.cash \
    ZCASH_RPC_ALLOWIP=0.0.0.0/0

ARG GOSU_VERSION=1.7
ARG ZCASH_VERSION=1.0.15

RUN useradd -d "$ZCASH_HOME" -U zcash \
    && mkdir -p "$ZCASH_HOME/.zcash" "$ZCASH_HOME/.zcash-params" \
    && chown -R "$ZCASH_USER:$ZCASH_USER" "$ZCASH_HOME" \
    && apt-get update && apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      wget \
    && apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 63C4A2169C1B2FA2 \
    && echo "deb https://apt.z.cash/ jessie main" > /etc/apt/sources.list.d/zcash.list \
    && apt-get update && apt-get install -y "zcash=$ZCASH_VERSION" \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove apt-transport-https \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

VOLUME ["$ZCASH_HOME/.zcash-params", "$ZCASH_HOME/.zcash"]
EXPOSE $ZCASH_RPC_PORT

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
