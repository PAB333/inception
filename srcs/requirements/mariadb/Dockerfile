# on utilise l'avant derniere version stable de debian
FROM debian:bookworm

# on update et installe mariaDB
RUN apt-get update && apt-get install -y mariadb-server

# on copie le fichier de config reseau dans le dossier systeme de mariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# on copie le script d'initialisation a la racine de du conteneur
COPY tools/mariadb.sh /mariadb.sh

# on met bien les droits d'execution au script dans le conteneur
RUN chmod +x /mariadb.sh

# on expose le port 3306 afin de communiquer avec le reseau du docker
EXPOSE 3306

# on definie le script comme point d'entree principal
ENTRYPOINT [ "/mariadb.sh" ]
