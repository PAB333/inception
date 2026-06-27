FROM debian:bookworm

# Installation de NGINX et OpenSSL
RUN apt-get update -y && apt-get install -y nginx openssl

# Creation du dossier pour le certificat SSL
RUN mkdir -p /etc/nginx/ssl

# Generation du certificat SSL
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pibreiss.42.fr/UID=pibreiss"

# Creation du dossier pour les PID de NGINX
RUN mkdir -p /var/run/nginx

# Copie du fichier de configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Droits d'acces pour le dossier web
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

# Lancement de NGINX
CMD [ "nginx", "-g", "daemon off;" ]
