ARG PHP_VERSION
ARG PHP_VARIANT
ARG ARCH

FROM arm64v8/php:$PHP_VERSION-$PHP_VARIANT as aarch64
FROM arm32v7/php:$PHP_VERSION-$PHP_VARIANT as arm
FROM php:$PHP_VERSION-$PHP_VARIANT as x86_64

FROM multiarch/qemu-user-static:${ARCH} as qemu

FROM $ARCH

COPY --from=qemu /usr/bin/qemu-${ARCH}-static /usr/bin

RUN apt-get update && apt-get install -y \
    mplayer \
    libpng-dev \
    libzip-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    sqlite3 \
    libsqlite3-dev

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
 && docker-php-source delete \
 && rm -rf /var/lib/apt/lists/*;
