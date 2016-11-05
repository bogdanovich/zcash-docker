#!/bin/bash

set -e

if [[ "$#" == '0' ]]; then
    set -- zcashd
fi

if [[ $1 == zcash* && "$(id -u)" = '0' ]]; then
    chown -R "$ZCASH_USER:$ZCASH_USER" "$ZCASH_HOME"
    exec gosu "$ZCASH_USER" "$BASH_SOURCE" "$@"
fi

if [[ $1 == zcash* && (! -f "$ZCASH_HOME/.zcash-params/sprout-proving.key" || ! -f "$ZCASH_HOME/.zcash-params/sprout-verifying.key") ]]; then
    zcash-fetch-params
fi

if [[ ! -f "$ZCASH_HOME/.zcash/zcash.conf" ]]; then
    cat << EOF > "$ZCASH_HOME/.zcash/zcash.conf"
addnode=mainnet.z.cash
printtoconsole=1

rpcuser=${ZCASH_RPC_USER}
rpcpassword=${ZCASH_RPC_PASSWORD:-`head -c 32 /dev/urandom | base64`}
rpcport=${ZCASH_RPC_PORT}
gen=${ZCASH_GEN}
genproclimit=${ZCASH_GEN_PROC_LIMIT}
EOF
fi

exec "$@"
