#!/bin/bash

webroot=/var/www/html

echo date.timezone=Europe/London > /usr/local/etc/php/conf.d/timezone.ini

# chown -R www-data:www-data /var/www/html

# chown -Rf nginx:nginx /var/www/html

# find /var/www/html -type d -exec chmod 755 {} \;

# find /var/www/html -type f -exec chmod 644 {} \;

/usr/local/sbin/php-fpm --force-stderr --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/www.conf &

/usr/sbin/nginx -g "daemon off; error_log /dev/stderr info;"