NAME = inception

all: up

up:
	cd srcs && docker-compose up -d --build

down:
	cd srcs && docker-compose down

clean:
	docker system prune -af --volumes

fclean: clean
	docker volume rm srcs_mariadb_data srcs_wordpress_data

re: fclean all
