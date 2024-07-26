#!/bin/bash

webroot=/var/www/html

echo date.timezone=Europe/London > /usr/local/etc/php/conf.d/timezone.ini

/usr/local/sbin/php-fpm --force-stderr --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/www.conf &

/usr/sbin/nginx -g "daemon off; error_log /dev/stderr info;"