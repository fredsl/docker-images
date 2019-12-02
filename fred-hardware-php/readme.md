# Fred Hardware PHP

A PHP image that includes several libraries compiled to `x86_64 (amd64)`, `armv7 (armv7hf)` and `arm64 (aarch64)`

* curl
* gd
* json 
* mbstring 
* pdo 
* pdo_sqlite 
* xml 
* xmlrpc 
* simplexml 
* sockets 

The docker images are build using Github workflow and published to `fredsl/fred-hardware-php`.

Current tags are:

* 7.3.1-fpm-amd64
* 7.3.1-fpm-armv7hf
* 7.3.1-fpm-aarch64

In future, when Balena.io fixes the [issue](https://forums.balena.io/t/use-pre-build-multiarch-image-from-docker-hub/26110/21) 
of not supporting multi-arch image, this project will generate an image with single tag using the following command.


```
docker buildx build \
  --build-arg PHP_VERSION=7.3.1 \
  --build-arg PHP_VARIANT=fpm \
  --platform linux/arm/v7,linux/amd64,linux/arm64 \
  -t fredsl/fred-hardware-php:7.3.1-fpm-armv7hf \
  --load \
  --file ./fred-hardware-php/Dockerfile ./fred-hardware-php

docker push fredsl/fred-hardware-php:7.3.1-fpm
```