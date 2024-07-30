YML_FILE :=				docker-compose.yml
DOCKER_VOLUME_LIST :=	$(shell docker volume ls -q)

all: build 

check_env:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Error: $(ENV_FILE) not found. Please create the .env file."; \
		exit 1; \
	fi
	@if [ ! -f $(DOCKER_ENV_FILE) ]; then \
		echo "Error: $(DOCKER_ENV_FILE) not found. Please create the .envdocker file in the ./backend/ directory."; \
		exit 1; \
	fi

build:
	docker-compose -f $(YML_FILE) up --build -d

stop:
	docker-compose -f $(YML_FILE) stop

re: fclean all

clean: stop
	docker-compose -f $(YML_FILE) down -v 

fclean: clean
	# sudo rm -rf ${HOME}/volume
	docker system prune -a -f --volumes
	@if [ -n "$(DOCKER_VOLUME_LIST)" ]; then docker volume rm $(DOCKER_VOLUME_LIST) 2> /dev/null || true; fi
	@echo "Cleaning: success!"

.PHONY: clean fclean all re