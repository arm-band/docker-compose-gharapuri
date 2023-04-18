
FROM ubuntu:latest
# args
ARG CONTAINER_HOST_NAME
ARG WEB_ROOT_DIRECTORY
ARG WEB_CONTAINER_PORTNUM
ARG PHP_VERSION
# install tzdata without interactive
ENV DEBIAN_FRONTEND=noninteractive
# apt update & install
RUN apt update \
 && apt install -y sudo \
                   vim \
                   less \
                   procps \
                   # network ss (instaed of netstat)
                   iproute2 \
                   # apache
                   apache2 \
                   # zip
                   zip \
                   unzip \
                   # SSL
                   openssl \
                   # SSH
                   openssh-server \
                   # git
                   git \
                   # FTP
                   #vsftpd \
                   # pasword
                   #passwd \
                   # Set Timezone
                   tzdata \
                   # Set local to jp.
                   language-pack-ja \
                && update-locale LANG=ja_JP.UTF-8 \
                   # cleaning
                && apt clean \
                && rm -rf /var/lib/apt/lists/*
# set env
ENV TZ="Asia/Tokyo" \
    LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# add last
# RUN echo ServerTokens Prod >> /etc/apache2/apache2.conf
# install php
RUN apt update \
 && apt install -y php \
                libapache2-mod-php \
                php-fpm \
                php-common \
                php-mbstring \
                php-xmlrpc \
                php-gd \
                php-xml \
                php-cli \
                php-zip \
                php-curl \
                php-imagick \
                # SQLite
                php-sqlite3 \
                # MySQL
                #php-pdo \
                #php-mysql
                # cleaning
                && apt clean \
                && rm -rf /var/lib/apt/lists/*
# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer
# PHP
RUN mkdir -p /run/php
RUN chown www-data:www-data /run/php
# php log
RUN mkdir /var/log/php
RUN chown www-data /var/log/php
RUN chmod 755 /var/log/php
# SSL
RUN mkdir -p /etc/ssl/private
# volume directory
RUN mkdir /template
RUN mkdir /var/www/${WEB_ROOT_DIRECTORY}
RUN mkdir /var/www/${WEB_ROOT_DIRECTORY}/web
RUN mkdir /workspace
# SSH
RUN mkdir /var/run/sshd
# FTP
#RUN mkdir /var/log/vsftpd
#RUN mkdir /etc/vsftpd/user_conf
