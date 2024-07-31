FROM nginx

LABEL maintainer="Cyril H"

RUN rm -Rf /etc/nginx/nginx.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/sites-available/ && \
mkdir -p /etc/nginx/sites-enabled/ && \
rm -Rf /var/www/*

ADD scripts/start.sh /start.sh
RUN chmod +x /start.sh

ADD conf/nginx-site.conf /etc/nginx/sites-available/default.conf

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

EXPOSE 80

CMD ["/start.sh"]