#!/bin/bash

# on va dans le dossier qui va contenir les fichiers du site
cd /var/www/html

export SQL_PASSWORD=$(cat /run/secrets/db_password)
export WP_ADMIN_PASSWORD=$(cat /run/secrets/credentials)

# on attend que la base de donnees soit prete
until mysqladmin ping -h mariadb --silent; do
    sleep 2
done

# on installe wp-cli si il n'est pas deja telecharger
if [ ! -f "/usr/local/bin/wp" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# on verifie si wordpress est installe ou pas
if [ ! -f "wp-config.php" ]; then
    # on tellecharge les sources
    wp core download --allow-root
    # on genere un fichier de config en lui donnant les identifiant de la db
    wp config create --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost=mariadb --allow-root
    # on creer la structure de la base de donnee et aussi on creer le compte admin
    wp core install --url=https://${DOMAIN_NAME} --title="Inception" --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
    # on creer le deuxieme user
    wp user create ${WP_USER} ${WP_USER_EMAIL} --role=author --user_pass=${WP_USER_PASSWORD} --allow-root
fi

# on donne les droits a www-data (utilisateur linux standard) de tous les fichiers telecharges
chown -R www-data:www-data /var/www/html

# on execle processus PHP-FPM
exec /usr/sbin/php-fpm8.2 -F
