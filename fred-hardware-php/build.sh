#!/usr/bin/env bash

#sudo systemctl stop docker

#sudo rm /etc/docker/daemon.json
#sudo touch /etc/docker/daemon.json
#sudo echo "{ \"cgroup-parent\": \"/actions_job\", \"experimental\": \"enabled\" }" >> /etc/docker/daemon.json
#sudo sed -i -e 's/}$/,\"experimental\": \"enabled\" }/' /etc/docker/daemon.json
#cat  /etc/docker/daemon.json

export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1

wget -o buildx https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64
mv buildx /usr/lib/docker/cli-plugins/docker-buildx
sudo chmod a+x /usr/lib/docker/cli-plugins/docker-buildx
#sudo systemctl restart docker

#sudo systemctl status docker.service

#docker build --platform=local -o . git://github.com/docker/buildx
#mv buildx /usr/lib/docker/cli-plugins/docker-buildx

#docker --version
#docker info

#docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

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