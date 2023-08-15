COMPOSE_FILE=/home/abouazi/Desktop/Inception/srcs/docker-compose.yml

up:
	@mkdir -p /home/abouazi/data/wp
	@mkdir -p /home/abouazi/data/db
	@docker compose -f $(COMPOSE_FILE) up -d --build

down:
	@docker compose  -f $(COMPOSE_FILE) down

clean: down
	@docker volume rm srcs_WP srcs_DB

fclean:	down clean
	@docker system prune -fa
	@sudo rm -Rf /home/abouazi/data/db
	@sudo rm -Rf /home/abouazi/data/wp
	@sudo rm -rf /home/abouazi/data
