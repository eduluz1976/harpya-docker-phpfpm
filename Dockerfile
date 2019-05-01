FROM phalconphp/php-fpm:latest

WORKDIR /srv/app

COPY  run_fpm.sh /root

RUN echo "deb-src http://ppa.launchpad.net/chris-lea/libsodium/ubuntu precise main" >> /etc/apt/sources.list \
    && echo "deb http://ppa.launchpad.net/chris-lea/libsodium/ubuntu precise main" >> /etc/apt/sources.list \
    &&  apt-get update \
    && apt-get -y install gpg apt-utils gettext-base \
    &&  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 B9316A7BC7917B12 \
    && apt-get -y install --no-install-recommends curl git g++ gcc autoconf libc-dev pkg-config \
     libicu-dev libmcrypt-dev libpq-dev libxml2-dev unzip zlib1g-dev vim libsodium-dev \
    libcurl4-openssl-dev libssl-dev make \
    && docker-php-ext-install curl intl pdo pdo_mysql mbstring \
    && pecl install apcu libsodium \
    && curl --silent --show-error https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer \
    && pecl install mongodb \
    && echo "extension=mongodb.so" >  /usr/local/etc/php/conf.d/mongodb.ini \
    && apt-get autoremove && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "extension=sodium.so" > /usr/local/etc/php/conf.d/sodium.ini \
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
    && chown -R www-data:www-data /srv \
    && chmod 755 /root/run_fpm.sh

EXPOSE 9000
