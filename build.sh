#!/bin/bash

docker build --no-cache -t hackinglab/alpine-ttyd-rbash-operator:3.2.0 -t hackinglab/alpine-ttyd-rbash-operator:3.2 -t hackinglab/alpine-ttyd-rbash-operator:latest -f Dockerfile .
docker build --no-cache -t hackinglab/alpine-ttyd-rbash:3.2.0 -t hackinglab/alpine-ttyd-rbash:3.2 -t hackinglab/alpine-ttyd-rbash:latest -f Dockerfile .
