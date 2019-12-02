#!/usr/bin/env bash

export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1

sudo mkdir -p /usr/local/lib/docker/cli-plugins
docker build --platform=local -o . git://github.com/docker/buildx
sudo mv buildx  /usr/local/lib/docker/cli-plugins/docker-buildx
sudo chmod a+x  /usr/local/lib/docker/cli-plugins/docker-buildx

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker buildx create --name xbuilder
docker buildx use xbuilder
docker buildx inspect --bootstrap
