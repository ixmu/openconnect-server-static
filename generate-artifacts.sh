#!/bin/sh
docker build -t ocserv-static .
CONTAINER=$(docker create ocserv-static)

mkdir -p ./dist/bin ./dist/libexec ./dist/sbin

docker cp "${CONTAINER}:/usr/local/bin/occtl" ./dist/bin
docker cp "${CONTAINER}:/usr/local/bin/ocpasswd" ./dist/bin
docker cp "${CONTAINER}:/usr/local/libexec/ocserv-fw" ./dist/libexec
docker cp "${CONTAINER}:/usr/local/sbin/ocserv" ./dist/sbin
docker cp "${CONTAINER}:/usr/local/sbin/ocserv-worker" ./dist/sbin

docker rm "${CONTAINER}"
docker rmi ocserv-static

XZ_OPT=-9 tar -C ./dist -Jcvf ./dist/ocserv-static.tar.xz bin libexec sbin
rm -f -R ./dist/bin ./dist/libexec ./dist/sbin
