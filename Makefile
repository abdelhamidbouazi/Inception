COMPOSE_FILE := /home/abouazi/Inception/srcs/docker-compose.yml
DATA_DIR := /home/abouazi/data
WP_VOLUME := wp_volume
DB_VOLUME := db_volume

build:
	@mkdir -p $(DATA_DIR)/wp
	@mkdir -p $(DATA_DIR)/db
	@docker-compose -f $(COMPOSE_FILE) build

start:
	@mkdir -p $(DATA_DIR)/wp
	@mkdir -p $(DATA_DIR)/db
	@docker-compose -f $(COMPOSE_FILE) up -d

down:
	@docker-compose -f $(COMPOSE_FILE) down

clean: down
	@docker volume rm $(WP_VOLUME) $(DB_VOLUME)

prune: clean
	@docker system prune -fa
	@sudo rm -Rf $(DATA_DIR)/wp
	@sudo rm -Rf $(DATA_DIR)/db
	@sudo rm -rf $(DATA_DIR)

.PHONY: up down clean fclean
