#!/bin/bash

# gen key & certificate
## localhost
openssl req -new -newkey rsa:2048 -nodes \
        -out /etc/pki/tls/certs/localhost.csr \
        -keyout /etc/pki/tls/private/localhost.key \
        -subj "/C=/ST=/L=/O=/OU=/CN=www.example.com"
openssl x509 -days 365 -req \
        -signkey /etc/pki/tls/private/localhost.key \
        -in /etc/pki/tls/certs/localhost.csr \
        -out /etc/pki/tls/certs/localhost.crt
## .env domain
openssl req -new -newkey rsa:2048 -nodes \
        -out /etc/ssl/private/server.csr \
        -keyout /etc/ssl/private/server.key \
        -subj "/C=/ST=/L=/O=/OU=/CN=*.${2}"
openssl x509 -days 365 -req \
        -signkey /etc/ssl/private/server.key \
        -in /etc/ssl/private/server.csr \
        -out /etc/ssl/private/server.crt

# ●●●SSLのプロトコルが低い？

# setting file replace and copy
sed -e "s/WEB_ROOT_DIRECTORY/${1}/gi" \
    -e "s/WEB_DOMAIN/${2}/gi" \
    -e "s/WEB_HOST_PORTNUM/${3}/gi" \
    -e "s/WEB_CONTAINER_PORTNUM/${4}/gi" \
    -e "s/WEB_HOST_PORTSSL/${5}/gi" \
    -e "s/WEB_CONTAINER_PORTSSL/${6}/gi" \
        /template/apache/apache_vh.conf > /etc/apache2/sites-available/${1}.conf
sed -e "s/WEB_ROOT_DIRECTORY/${1}/gi" \
    -e "s/WEB_DOMAIN/${2}/gi" \
    -e "s/WEB_HOST_PORTNUM/${3}/gi" \
    -e "s/WEB_CONTAINER_PORTNUM/${4}/gi" \
    -e "s/WEB_HOST_PORTSSL/${5}/gi" \
    -e "s/WEB_CONTAINER_PORTSSL/${6}/gi" \
        /template/apache/apache_vh_ssl.conf > /etc/apache2/sites-available/${1}_ssl.conf

#cp /template/apache/php.conf /etc/httpd/conf.d/php.conf
#cp /template/apache/ssl.conf /etc/httpd/conf.d/ssl.conf
#cp /template/apache/modules/00-mpm.conf /etc/httpd/conf.modules.d/00-mpm.conf

# apache module enable
a2enmod ssl proxy_fcgi setenvif rewrite
# apache conf enable
echo ServerName www.example.com:${4} >> /etc/apache2/conf-available/example.conf
a2enconf example php${11}-fpm
# apache cirtual site enable
a2ensite ${1} ${1}_ssl
# apache service start
service apache2 start

# PHP
/usr/sbin/php-fpm${11} &

# SSH
sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "${7}:${8}" | chpasswd
ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
/usr/sbin/sshd -D &

# FTP
#useradd ${9}
#echo ${10} | passwd --stdin ${9}
#
#cp /template/vsftpd/chroot_list /etc/vsftpd/chroot_list
#
#sed -e "s/WEB_FTP_USER/${9}/gi" \
#        /template/vsftpd/user_list > /etc/vsftpd/user_list
#sed -e "s/WEB_ROOT_DIRECTORY/${1}/gi" \
#        /template/vsftpd/WEB_FTP_USER > /etc/vsftpd/user_conf/${9}
#
#/usr/sbin/vsftpd &
