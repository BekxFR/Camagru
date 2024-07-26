FROM php:8.2.7-fpm-alpine3.18

LABEL maintainer="Cyril H"

ENV php_conf=/usr/local/etc/php-fpm.conf
ENV fpm_conf=/usr/local/etc/php-fpm.d/www.conf
ENV php_vars=/usr/local/etc/php/conf.d/docker-vars.ini

RUN apk add --no-cache nginx

RUN apk update && apk upgrade && \
apk add --no-cache \
bash \
coreutils

ADD conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/sites-available/ && \
mkdir -p /etc/nginx/sites-enabled/ && \
rm -Rf /var/www/* && \
mkdir /var/www/html/

ADD scripts/start.sh /start.sh

ADD conf/nginx-site.conf /etc/nginx/sites-available/default.conf

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

RUN chmod 755 /start.sh

ADD src/ /var/www/html/

EXPOSE 80

WORKDIR "/var/www/html"

# CMD ["sh", "-c", "nginx && php-fpm"]
CMD ["/start.sh"]