#!/usr/bin/env bash

export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1

sudo mkdir -p /usr/local/lib/docker/cli-plugins
wget -O buildx https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64
sudo mv buildx  /usr/local/lib/docker/cli-plugins/docker-buildx
sudo chmod a+x  /usr/local/lib/docker/cli-plugins/docker-buildx

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker buildx create --name xbuilder
docker buildx use xbuilder
