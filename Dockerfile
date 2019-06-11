FROM php:7.3-fpm
MAINTAINER Mateusz Lerczak <mateusz@lerczak.eu>

ARG SYMFONY_ROOT="/srv/symfony"
ARG PATH_XDEBUG_INI="/usr/local/etc/php/conf.d/xdebug.ini"

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
    curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y \
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
    pecl install xdebug \
    && sed -i "1izend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" ${PATH_XDEBUG_INI}


RUN \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN \
    mkdir -p /var/log/supervisor

CMD ["/usr/bin/supervisord"]

WORKDIR ${SYMFONY_ROOT}
