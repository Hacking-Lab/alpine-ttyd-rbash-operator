#!/bin/bash
docker build --no-cache -t hackinglab/alpine-ttyd-rbash-operator:$1.0 -t hackinglab/alpine-ttyd-rbash-operator:$1 -t hackinglab/alpine-ttyd-rbash-operator:latest -f Dockerfile .
docker build --no-cache -t hackinglab/alpine-ttyd-rbash:$1.0 -t hackinglab/alpine-ttyd-rbash:$1 -t hackinglab/alpine-ttyd-rbash:latest -f Dockerfile .

docker push hackinglab/alpine-ttyd-rbash-operator
docker push hackinglab/alpine-ttyd-rbash-operator:$1
docker push hackinglab/alpine-ttyd-rbash-operator:$1.0
docker push hackinglab/alpine-ttyd-rbash
docker push hackinglab/alpine-ttyd-rbash:$1
docker push hackinglab/alpine-ttyd-rbash:$1.0

