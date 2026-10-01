include .env
export

export PROJECT_ROOT=$(shell pwd)



# запуск сервиса
env-up:
	docker compose up -d task-manager-postgres

# остановка сервиса
env-down:
	docker compose down task-manager-postgres

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


# создать файлы миграции
migrate-create:
	@if [ -z "\$(seq)" ]; then \
		echo "отсуствует необходимый параметр \`seq\`. Пример: make migrate-create seq=init"; \
		exit 1; \
	fi
	MSYS2_ARG_CONV_EXCL="*" docker compose run --rm task-manager-migrate create \
		-ext sql \
		-dir ${PROJECT_ROOT}/migrations \
		-seq "$(seq)"



test-target:
	@echo "value: $(var)"