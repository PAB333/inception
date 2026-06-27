NAME = inception

all: up

up:
	mkdir -p /home/pibreiss/data/mariadb
	mkdir -p /home/pibreiss/data/wordpress
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a

fclean:
	docker compose -f srcs/docker-compose.yml down -v
	docker system prune -a --volumes
	sudo rm -rf /home/pibreiss/data/wordpress/*
	sudo rm -rf /home/pibreiss/data/mariadb/*

re: fclean all

.PHONY: all up down clean fclean re
