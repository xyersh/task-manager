include .env
export

# export PROJECT_ROOT=$(shell pwd)
export PROJECT_ROOT=$(CURDIR)


# запуск сервиса
env-up:
	docker compose up -d --wait task-manager-postgres

# остановка сервиса
env-down:
	@docker compose down task-manager-postgres

# полная очистка БД
env-cleanup:
	@read -p "Очистить все volume файлы окружения? Опасность утери данных [y/N]: " ans; \
	if [ "$$ans" = "y" ]; then \
		docker compose down task-manager-postgres && \
		rm -rf out/pgdata && \
		echo "Файлы окружения очищены"; \
	else \
		echo "Очистка окружения отменена"; \
	fi

env-port-forward:
	@docker compose up -d port-forwarder


env-port-down:
	@docker compose down port-forwarder



# создать файлы миграции
migrate-create:
	@if [ -z "$(seq)" ]; then \
		echo 'отсуствует необходимый параметр "seq". Пример: make migrate-create seq=init'; \
		exit 1; \
	fi
	@docker compose run --rm task-manager-migrate create \
		-ext sql \
		-dir ./migrations \
		-seq "$(seq)"


# up/down миграции 
migrate-action:
	@if [ -z "\$(action)" ]; then \
		echo "отсуствует необходимый параметр \`action\`. Пример: make migrate-action action= up 1"; \
		exit 1; \
	fi
	@docker compose run --rm task-manager-migrate \
		-path /migrations \
		-database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@task-manager-postgres:5432/${POSTGRES_DB}?sslmode=disable \
		"$(action)"


migrate-up:
	@make migrate-action action=up

migrate-down:
	@make migrate-action action=down




test-target:
	@echo "value: 			  $(var)" 
	@echo "CURDIR:            $(CURDIR)"
	@echo "PROJECT_ROOT:      ${PROJECT_ROOT}" 
	@echo "POSTGRES_USER:     ${POSTGRES_USER}" 
	@echo "POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}" 
	@echo "POSTGRES_DB:       ${POSTGRES_DB}"