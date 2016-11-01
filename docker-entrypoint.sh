#!/bin/bash

set -e

if [[ "$#" == '0' ]]; then
    set -- zcashd
fi

if [[ ( "$1" == 'zcashd' || "$1" == 'zcash-cli' ) && ! -f '/root/.zcash-params/sprout-proving.key.dl' ]]; then
    zcash-fetch-params
fi

if [[ ! -f '/root/.zcash/zcash.conf' ]]; then
    mkdir -p '/root/.zcash'

    cat << EOF > '/root/.zcash/zcash.conf'
addnode=mainnet.z.cash
printtoconsole=1

rpcuser=${ZCASH_RPC_USER}
rpcpassword=${ZCASH_RPC_PASSWORD:-`head -c 32 /dev/urandom | base64`}
gen=${ZCASH_GEN}
genproclimit=${ZCASH_GEN_PROC_LIMIT}
EOF
fi

# TODO: Run as non-priveleged
exec "$@"
