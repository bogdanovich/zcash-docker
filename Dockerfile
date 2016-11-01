FROM debian:jessie
MAINTAINER Elisey Zanko <elisey.zanko@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      wget \
    && apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 63C4A2169C1B2FA2 \
    && echo "deb https://apt.z.cash/ jessie main" > /etc/apt/sources.list.d/zcash.list \
    && apt-get update && apt-get install -y zcash \
    && rm -rf /var/lib/apt/lists/*

ENV ZCASH_RPC_USER=zcash \
    ZCASH_RPC_PASSWORD= \
    ZCASH_GEN=0 \
    ZCASH_GEN_PROC_LIMIT=-1

VOLUME ["/root/.zcash-params", "/root/.zcash"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
