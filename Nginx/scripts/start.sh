#!/bin/bash

webroot=/var/www/html

echo date.timezone=Europe/London > /usr/local/etc/php/conf.d/timezone.ini

# find /var/www/html -type d -exec chmod 755 {} \;
# find /var/www/html -type f -exec chmod 644 {} \;

/usr/sbin/nginx -g "daemon off; error_log /dev/stderr info;"