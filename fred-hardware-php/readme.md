# Docker Image Multi-arch

This is a work in progress in an attempt of getting a single multi-arch php image across multiple arch devices.

It still not possible due to the Balena's limitation 

https://forums.balena.io/t/use-pre-build-multiarch-image-from-docker-hub/26110/21

## Preparing the buildx

```bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker buildx create --name xbuilder
docker buildx use xbuilder
docker buildx inspect --bootstrap
```


## Building images

```bash
docker buildx build --platform linux/arm/v7,linux/amd64,linux/arm64 \
     --build-arg PHP_VERSION=7.3 \
     --build-arg PHP_VARIANT=fpm \
     -t fredsl/fred-hardware-php:7.3 \
     --push .
```

