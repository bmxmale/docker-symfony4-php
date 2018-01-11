FROM php:7.2-fpm
MAINTAINER Mateusz Lerczak <mlerczak@pl.sii.eu>

ARG SYMFONY_ROOT="/srv/symfony"

ENV PHP_PORT 9000
ENV PHP_PM dynamic
ENV PHP_PM_MAX_CHILDREN 10
ENV PHP_PM_START_SERVERS 1
ENV PHP_PM_MIN_SPARE_SERVERS 1
ENV PHP_PM_MAX_SPARE_SERVERS 6

RUN \
    apt-get update \
    && apt-get install -y \
        build-essential \
        libssl-dev \
        gnupg

RUN \
    curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN \
    apt-get install -y \
        nodejs \
        supervisor \
        ssmtp \
        libicu-dev

RUN \
    docker-php-ext-install \
        intl \
        pcntl \
        opcache \
        pdo \
        pdo_mysql

COPY container /

RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN \
    mkdir -p /var/log/supervisor

CMD ["/usr/bin/supervisord"]

WORKDIR ${SYMFONY_ROOT}
