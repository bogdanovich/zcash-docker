## Dockerized Zcash

[![](https://images.microbadger.com/badges/image/bogdanovich/zcash-docker.svg)](https://microbadger.com/images/bogdanovich/zcash-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/bogdanovich/zcash-docker.svg)](https://microbadger.com/images/bogdanovich/zcash-docker "Get your own version badge on microbadger.com")

## Run:

```
docker volume create zcash-params
docker volume create zcash
```

```
sudo docker run -d -e ZCASH_USER='zcash' \
-e ZCASH_HOME='/zcash' \
-e ZCASH_RPC_USER='zcash' \
-e ZCASH_RPC_PASSWORD='zcash' \
-e ZCASH_GEN=0 \
-e ZCASH_TESTNET=1 \
-e ZCASH_ADDNODE='betatestnet.z.cash' \
-e ZCASH_RPC_ALLOWIP='0.0.0.0/0' \
-p 127.0.0.1:8232:8232 \
-v zcash-params:/zcash/.zcash-params:rw \
-v zcash:/zcash/.zcash:rw \
--name zcash bogdanovich/zcash-docker
```

### API:
```
$ docker exec -u zcash zcash zcash-cli getinfo
{
  "version": 1001550,
  "protocolversion": 170003,
  "walletversion": 60000,
  "balance": 0.00000000,
  "blocks": 6705,
  "timeoffset": 0,
  "connections": 2,
  "proxy": "",
  "difficulty": 17.40953531801278,
  "testnet": true,
  "keypoololdest": 1520226026,
  "keypoolsize": 101,
  "paytxfee": 0.00000000,
  "relayfee": 0.00000100,
  "errors": ""
}
```

### RPC:
After zcash-params successfully downloaded:
```
curl --user zcash:zcash --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getinfo"}' -H 'content-type: text/plain;' http://127.0.0.1:8232/ | jq .
{
  "result": {
    "version": 1001550,
    "protocolversion": 170003,
    "walletversion": 60000,
    "balance": 0,
    "blocks": 8176,
    "timeoffset": 0,
    "connections": 2,
    "proxy": "",
    "difficulty": 86.03871622843062,
    "testnet": true,
    "keypoololdest": 1520226026,
    "keypoolsize": 101,
    "paytxfee": 0,
    "relayfee": 1e-06,
    "errors": ""
  },
  "error": null,
  "id": "curltest"
}
```
