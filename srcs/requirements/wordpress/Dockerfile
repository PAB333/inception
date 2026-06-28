FROM debian:bookworm

RUN apt-get update -y && apt-get install -y curl php8.2-fpm php8.2-mysqli mariadb-client

RUN mkdir -p /run/php

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/wordpress.sh"]
