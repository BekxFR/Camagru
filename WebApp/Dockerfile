FROM php:8.2.7-fpm-alpine3.18

LABEL maintainer="Cyril H"

ENV php_conf=/usr/local/etc/php-fpm.conf
ENV fpm_conf=/usr/local/etc/php-fpm.d/www.conf
ENV php_vars=/usr/local/etc/php/conf.d/docker-vars.ini

RUN apk update && apk upgrade &&\
apk add --no-cache \
bash \
coreutils

RUN rm -Rf /var/www/* && \
mkdir /var/www/html/

RUN echo "cgi.fix_pathinfo=0" > ${php_vars} &&\
echo "upload_max_filesize = 100M"  >> ${php_vars} &&\
echo "post_max_size = 100M"  >> ${php_vars} &&\
echo "variables_order = \"EGPCS\""  >> ${php_vars} && \
echo "memory_limit = 128M"  >> ${php_vars} && \
sed -i \
    -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
    -e "s/pm.max_children = 5/pm.max_children = 4/g" \
    -e "s/pm.start_servers = 2/pm.start_servers = 3/g" \
    -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" \
    -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" \
    -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" \
    -e "s/listen = 127.0.0.1:9000/listen = 9000/g" \
    -e "s/;listen.mode = 0660/listen.mode = 0660/g" \
    -e "s/;listen.owner = www-data/listen.owner = www-data/g" \
    -e "s/;listen.group = www-data/listen.group = www-data/g" \
    -e "s/^;clear_env = no$/clear_env = no/" \
    ${fpm_conf}

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
sed -i \
-e "s/;opcache/opcache/g" \
-e "s/;zend_extension=opcache/zend_extension=opcache/g" \
/usr/local/etc/php/php.ini

ADD scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9000

CMD ["/start.sh"]