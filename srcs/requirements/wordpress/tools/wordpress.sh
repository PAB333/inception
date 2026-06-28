#!/bin/bash

cd /var/www/html

export SQL_PASSWORD=$(cat /run/secrets/db_password)
export WP_ADMIN_PASSWORD=$(cat /run/secrets/credentials)

until mysqladmin ping -h mariadb --silent; do
    sleep 2
done

if [ ! -f "/usr/local/bin/wp" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root

    wp config create --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost=mariadb --allow-root

    wp core install --url=https://${DOMAIN_NAME} --title="Inception" --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root

    wp user create ${WP_USER} ${WP_USER_EMAIL} --role=author --user_pass=${WP_USER_PASSWORD} --allow-root
fi

chown -R www-data:www-data /var/www/html

exec /usr/sbin/php-fpm8.2 -F
