ARG PHP_VERSION
ARG PHP_VARIANT

FROM php:$PHP_VERSION-$PHP_VARIANT

#ADD /usr/bin/qemu-aarch64-static /usr/bin/qemu-aarch64-static
ADD /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static

ENV PHP_DEV_LIBS="libpng-dev \
                  libzip-dev \
                  curl-dev \
                  libxml2-dev \
                  sqlite-dev"


RUN apk add --no-cache \
    alsa-utils \
    libpng \
    libzip \
    $PHP_DEV_LIBS

RUN docker-php-source extract \
 && docker-php-ext-install -j$(nproc) \
    curl \
    gd \
    json \
    mbstring \
    pdo \
    pdo_sqlite \
    xml \
    xmlrpc \
    simplexml \
    sockets \
 && docker-php-source delete

RUN apk del $PHP_DEV_LIBS
