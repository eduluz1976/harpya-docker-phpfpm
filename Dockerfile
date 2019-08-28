FROM centos:latest

LABEL name="harpya-fpm"
LABEL vcs-url="https://github.com/eduluz1976/harpya-docker-phpfpm"
LABEL maintainer="Eduardo Luz <eduardo at eduardo-luz dot com>"
LABEL version="0.2.0"
LABEL release-date="2019-08-26"

WORKDIR /srv/app

RUN  yum -y install epel-release
RUN  yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN  yum-config-manager --enable remi-php72

RUN curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.rpm.sh |  bash

RUN  yum -y install initscripts
RUN  yum -y update
RUN  yum -y install php php-common.x86_64 php-devel.x86_64  php-fpm.x86_64 php-gd.x86_64 \
                    php-intl.x86_64 php-json.x86_64 php-mbstring.x86_64 php-mysqlnd.x86_64 \
                    php-pdo.x86_64 php-pecl-igbinary.x86_64 php-pecl-mongodb.x86_64 \
                    php-pecl-swoole4.x86_64 php-pgsql.x86_64 php-process.x86_64 php-bcmath.x86_64 \
                    php-xml.x86_64 php-opcache.x86_64 php-pecl-redis.x86_64 php-pecl-zip.x86_64 \
                    php72u-phalcon php-phalcon4.x86_64 php-sodium.x86_64 composer.noarch \
                    php-pecl-decimal.x86_64 php-pecl-ds.x86_64

RUN yum -y install wget curl vim unzip git

RUN composer global require --no-interaction hirak/prestissimo

RUN mkdir /run/php-fpm
RUN rm -f /etc/php-fpm.d/www.conf

ENV PATH $HOME/.composer/vendor/bin:$PATH

COPY www.conf /etc/php-fpm.d/

EXPOSE 9000

#start PHP-FPM
CMD [ "php-fpm", "-F"]
