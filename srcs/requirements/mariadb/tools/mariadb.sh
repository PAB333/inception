#!/bin/bash

# ce fichier permet de creer la base et des utilisateurs a partir des variables d'environnement

# on demarre le service MariaDB en arriere plan pour la configuration
service mariadb start

# on laisse le temps au deamon de demarrer
sleep 5

# on creer la base de donnee si elle n'existe pas deja
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# on creer l'utilisateur normal
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# on attribue les droit sur la base de donnee a cet utilisateur
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY `${SQL_PASSWORD}`;"

# on modifie le mdp de l'utilisateur
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# on applique les nouveau privileges
mysql -e "FLUSH PRIVILEGES;"

# on arrete le deamon avant de relancer le processus principal
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# ici la commande exec permet de remplacer le script bash actuel par le processus mysqld_safe, MariaDB devient le PID1
exec mysqld_safe
