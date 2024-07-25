FROM php:8.2.7-fpm-alpine3.18

LABEL maintainer="Cyril H"

RUN apk add --no-cache nginx

RUN apk update && apk upgrade &&\
apk add --no-cache

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/sites-available/

ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

ADD src/ /var/www/html/

EXPOSE 80

WORKDIR "/var/www/html"

# CMD ["sh", "-c", "nginx && php-fpm"]
CMD ["/start.sh"]