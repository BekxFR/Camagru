FROM php:8.2.7-fpm-alpine3.18

LABEL maintainer="Cyril H"

ENV php_conf=/usr/local/etc/php-fpm.conf
ENV fpm_conf=/usr/local/etc/php-fpm.d/www.conf
ENV php_vars=/usr/local/etc/php/conf.d/docker-vars.ini

RUN apk add --no-cache nginx

RUN apk update && apk upgrade &&\
apk add --no-cache \
bash \
coreutils

RUN rm -Rf /etc/nginx/nginx.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/sites-available/ && \
mkdir -p /etc/nginx/sites-enabled/ && \
rm -Rf /var/www/* && \
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
    -e "s/user = www-data/user = nginx/g" \
    -e "s/group = www-data/group = nginx/g" \
    -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
    -e "s/;listen.owner = www-data/listen.owner = nginx/g" \
    -e "s/;listen.group = www-data/listen.group = nginx/g" \
    -e "s/;listen.group = nginx/listen.group = nginx/g" \
    -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" \
    -e "s/^;clear_env = no$/clear_env = no/" \
    ${fpm_conf}

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
sed -i \
-e "s/;opcache/opcache/g" \
-e "s/;zend_extension=opcache/zend_extension=opcache/g" \
/usr/local/etc/php/php.ini

ADD scripts/start.sh /start.sh

ADD conf/nginx-site.conf /etc/nginx/sites-available/default.conf

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

RUN chmod 755 /start.sh

ADD src/ /var/www/html/

EXPOSE 80

WORKDIR "/var/www/html"

CMD ["/start.sh"]