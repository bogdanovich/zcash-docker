## Dockerized Zcash

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
