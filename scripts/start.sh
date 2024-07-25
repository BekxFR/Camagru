#!/bin/bash

/usr/local/sbin/php-fpm --force-stderr --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/www.conf

/usr/sbin/nginx -g "daemon off; error_log /dev/stderr info;"