#!/usr/bin/env bash

sudo sed -i -e 's/}$/,\"experimental\": \"enabled\" }/' /etc/docker/daemon.json
cat  /etc/docker/daemon.json

systemctl status docker.service
journalctl -xe

export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1

sudo systemctl restart docker

docker --version
docker info

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker buildx create --name xbuilder
docker buildx use xbuilder
docker buildx inspect --bootstrap

docker build \
     --build-arg ARCH=arm \
     --build-arg PHP_VERSION=$PHP_VERSION \
     --build-arg PHP_VARIANT=$PHP_VARIANT \
     -t $DOCKER_REPO:$PHP_VERSION-$PHP_VARIANT-armv7hf .

docker build \
     --build-arg ARCH=aarch64 \
     --build-arg PHP_VERSION=$PHP_VERSION \
     --build-arg PHP_VARIANT=$PHP_VARIANT \
     -t $DOCKER_REPO:$PHP_VERSION-$PHP_VARIANT-aarch64 .

docker build \
     --build-arg ARCH=x86_64 \
     --build-arg PHP_VERSION=$PHP_VERSION \
     --build-arg PHP_VARIANT=$PHP_VARIANT \
     -t $DOCKER_REPO:$PHP_VERSION-$PHP_VARIANT-amd64 \
     -t $DOCKER_REPO:$DOCKER_TAG .

docker push $DOCKER_REPO:$PHP_VERSION-$PHP_VARIANT-armv7hf
docker push $DOCKER_REPO:$PHP_VERSION-$PHP_VARIANT-aarch64
docker push $DOCKER_REPO:$PHP_VERSION-$PHP_VARIANT-amd64