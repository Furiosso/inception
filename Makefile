NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	@mkdir -p /home/dagimeno/data/wordpress_db /home/dagimeno/data/wordpress_files /home/dagimeno/data/redis_db /home/dagimeno/data/portainer
	@chmod +x ./srcs/requirements/tools/tls.sh
	@./srcs/requirements/tools/tls.sh
	@$(COMPOSE) up -d --build

build:
	@$(COMPOSE) build --no-cache

down:
	@$(COMPOSE) down

stop:
	@$(COMPOSE) stop

start:
	@$(COMPOSE) start

restart: down up

clean:
	@$(COMPOSE) down --volumes

fclean: clean
	@docker system prune -af --volumes
	@rm -rf secrets
	@docker volume ls -q | grep inception | xargs -r docker volume rm

re: fclean all

.PHONY: all up build down stop start restart clean fclean re
