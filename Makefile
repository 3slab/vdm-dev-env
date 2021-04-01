.PHONY: help up realup build down reload ps logs test test-library-bundle coverage install-app go-source

default: help

help:
	@echo "Available make commands:\n"; \
	echo  "Docker related:"; \
	echo  "\033[0;32mbuild\033[0m                 Builds images (shortcut for docker-compose build)"; \
	echo  "\033[0;32mup\033[0m                    Boots containers (shortcut for docker-compose up)"; \
	echo  "\033[0;32mdown\033[0m                  Shuts down containers (shortcut for docker-compose down)"; \
	echo  "\033[0;32mreload\033[0m                Runs down + up"; \
	echo  "\nSubmodules installation:"; \
	echo  "\033[0;32minstall\033[0m               Installs projects dependencies"; \
	echo  "\033[0;32minstall-app\033[0m           Installs APP dependencies"; \
	echo  "\nSSH shortcuts:"; \
	echo  "\nDebug:"; \
	echo  "\033[0;32mlogs\033[0m                  Shows logs (all containers)"; \
	echo  "";

build:
	@docker build -t 3slab/vdm-library-base:latest VdmLibraryBundle/; \
	docker-compose build

install: install-app

install-app:
	@docker-compose exec vdm_dev_app composer install --no-scripts
	@docker-compose exec vdm_dev_bundle composer install --no-scripts

up: realup

realup:
	@docker-compose up -d; \
	echo "\nEnjoy :)\n"

down:
	@docker-compose down --remove-orphans

reload: down up

ps:
	@docker-compose ps

logs:
	@docker-compose logs

#############
### TESTS ###
#############
test:
	@docker-compose exec vdm_dev_app php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit

coverage:
	@docker-compose exec vdm_dev_app php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit --coverage-html build/coverage

test-library-bundle:
	@docker-compose exec vdm_dev_bundle php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit Tests/

# Shortcuts
go-source:
	@docker exec -it  vdm_dev_app /bin/bash

kafka-collect-producer:
	@docker-compose exec vdm_dev_kafka /usr/bin/kafka-console-producer --broker-list localhost:9092 --topic test

kafka-collect-consumer:
	@docker-compose exec vdm_dev_kafka /usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic test