NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	chmod +x ./srcs/requirements/tools/tls.sh
	./srcs/requirements/tools/tls.sh
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
	@$(COMPOSE) down

fclean: clean
	@docker system prune -af

re: fclean all

ps:
	@$(COMPOSE) ps

logs:
	@$(COMPOSE) logs

.PHONY: all up down stop start restart clean fclean re ps logs
