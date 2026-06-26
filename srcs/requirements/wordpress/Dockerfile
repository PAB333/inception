FROM debian:bookworm

RUN apt-get update -y && apt-get install -y curl php8.2-fpm php8.2-mysqli mariadb-client

# on creer le dossier necessaire au PID de PHP-FPM
RUN mkdir -p /run/php

# on copie la config PHP
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# on copie le script + droits
COPY tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh

# On creer le dossier du site web
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# On expose le port 9000 pour la communication avec Nginx
EXPOSE 9000

# Le point d'entree qui va configurer WP et lancer PHP-FPM
ENTRYPOINT ["/wordpress.sh"]
