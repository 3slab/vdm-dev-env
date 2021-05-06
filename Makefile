.PHONY: help up realup build down reload ps logs test
.PHONY: wikirecentchangeskafka-compute-topic-consumer wikirecentchangeskafka-collect-topic-consumer wikirecentchangeskafka-exec-collect wikirecentchangeskafka-exec-store
.PHONY: singlecomputedev-collect-consumer singlecomputedev-compute-consumer singlecomputedev-producer singlecomputedev-exec singlecomputelocal-exec
.PHONY: go-library-bundle test-library-bundle phpunit-library-bundle phpcs-library-bundle
.PHONY: go-http-transport-bundle test-http-transport-bundle phpunit-http-transport-bundle phpcs-http-transport-bundle
.PHONY: go-orm-transport-bundle test-orm-transport-bundle phpunit-orm-transport-bundle phpcs-orm-transport-bundle
.PHONY: go-healthcheck-bundle test-healthcheck-bundle phpunit-healthcheck-bundle phpcs-healthcheck-bundle
.PHONY: go-prometheus-bundle test-prometheus-bundle phpunit-prometheus-bundle phpcs-prometheus-bundle
.PHONY: coverage install-app go-source

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

test:
	@docker-compose exec vdm_dev_app php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit

coverage:
	@docker-compose exec vdm_dev_app php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit --coverage-html build/coverage


########################
### VdmLibraryBundle ###
########################
go-library-bundle:
	@docker exec -it  vdm_dev_library_bundle /bin/bash

test-library-bundle: phpcs-library-bundle phpunit-library-bundle

phpunit-library-bundle:
	@docker-compose exec vdm_dev_library_bundle php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit Tests/

phpcs-library-bundle:
	@docker-compose exec vdm_dev_library_bundle php -d memory_limit=-1 vendor/bin/phpcs --ignore=vendor/ --standard=PSR12 .


#####################################
### VdmLibraryHttpTransportBundle ###
#####################################
go-http-transport-bundle:
	@docker exec -it  vdm_dev_http_transport_bundle /bin/bash

test-http-transport-bundle: phpcs-http-transport-bundle phpunit-http-transport-bundle

phpunit-http-transport-bundle:
	@docker-compose exec vdm_dev_http_transport_bundle php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit Tests/

phpcs-http-transport-bundle:
	@docker-compose exec vdm_dev_http_transport_bundle php -d memory_limit=-1 vendor/bin/phpcs --ignore=vendor/ --standard=PSR12 .


#####################################
### VdmLibraryDoctrineOrmTransportBundle ###
#####################################
go-orm-transport-bundle:
	@docker exec -it  vdm_dev_orm_transport_bundle /bin/bash

test-orm-transport-bundle: phpcs-orm-transport-bundle phpunit-orm-transport-bundle

phpunit-orm-transport-bundle:
	@docker-compose exec vdm_dev_orm_transport_bundle php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit Tests/

phpcs-orm-transport-bundle:
	@docker-compose exec vdm_dev_orm_transport_bundle php -d memory_limit=-1 vendor/bin/phpcs --ignore=vendor/ --standard=PSR12 .


############################
### VdmHealthcheckBundle ###
############################
go-healthcheck-bundle:
	@docker exec -it  vdm_dev_healthcheck_bundle /bin/bash

test-healthcheck-bundle: phpcs-healthcheck-bundle phpunit-healthcheck-bundle

phpunit-healthcheck-bundle:
	@docker-compose exec vdm_dev_healthcheck_bundle php -d memory_limit=-1 ./vendor/bin/phpunit

phpcs-healthcheck-bundle:
	@docker-compose exec vdm_dev_healthcheck_bundle php -d memory_limit=-1 vendor/bin/phpcs --ignore=vendor/ --standard=PSR12 .


###########################
### VdmPrometheusBundle ###
###########################
go-prometheus-bundle:
	@docker exec -it  vdm_dev_prometheus_bundle /bin/bash

test-prometheus-bundle: phpcs-prometheus-bundle phpunit-prometheus-bundle

phpunit-prometheus-bundle:
	@docker-compose exec vdm_dev_prometheus_bundle php -d memory_limit=-1 ./vendor/bin/phpunit

phpcs-prometheus-bundle:
	@docker-compose exec vdm_dev_prometheus_bundle php -d memory_limit=-1 vendor/bin/phpcs --ignore=vendor/ --standard=PSR12 .


#########################################
### wikirecentchanges kafka shortcuts ###
#########################################
wikirecentchangeskafka-collect-topic-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t wikirecentchanges

wikirecentchangeskafka-compute-topic-consumer:
	#@docker-compose exec vdm_dev_kafka /usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic wikirecentchanges_enriched --from-beginning --property print.key=true --property print.headers=true --property print.timestamp=true
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t wikirecentchanges_enriched

wikirecentchangeskafka-exec-collect:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-collect vdm_dev_app bin/console --env=wikirecentchangeskafka vdm:collect wiki-collect-get -vvv

wikirecentchangeskafka-exec-compute:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-compute vdm_dev_app bin/console --env=wikirecentchangeskafka vdm:consume wiki-compute-get -vvv

wikirecentchangeskafka-exec-store:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-store vdm_dev_app bin/console --env=wikirecentchangeskafka vdm:consume wiki-store-get -vvv


#####################################
### singlecompute kafka shortcuts ###
#####################################
singlecomputedev-collect-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t singlecompute

singlecomputedev-compute-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t singlecompute_enriched

singlecomputedev-producer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -P -t singlecompute -H "type=App\SingleCompute\Message\ComputeInputMessage" -H "Content-Type=application/json"

singlecomputedev-exec:
	@docker-compose exec vdm_dev_app bin/console --env=singlecomputedev vdm:consume singlecompute-get -vvv

singlecomputelocal-exec:
	@docker-compose exec vdm_dev_app bin/console --env=singlecomputelocal vdm:consume singlecompute-get -vvv


# Shortcuts
go-source:
	@docker exec -it  vdm_dev_app /bin/bash

kafka-collect-producer:
	@docker-compose exec vdm_dev_kafka /usr/bin/kafka-console-producer --broker-list localhost:9092 --topic test

kafka-collect-consumer:
	@docker-compose exec vdm_dev_kafka /usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic test