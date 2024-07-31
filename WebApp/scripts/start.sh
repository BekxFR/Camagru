#!/bin/bash

echo date.timezone=Europe/London > /usr/local/etc/php/conf.d/timezone.ini

# find /var/www/html -type d -exec chmod 755 {} \;
# find /var/www/html -type f -exec chmod 644 {} \;

/usr/local/sbin/php-fpm --force-stderr --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/www.conf