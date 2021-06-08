WIKIRECENTCHANGES_KAFKA_COLLECT_TYPE ?= "App\\WikiRecentChanges\\Collect\\Message\\RecentChangeMessage"
WIKIRECENTCHANGES_KAFKA_COMPUTE_TYPE ?= "App\\WikiRecentChanges\\Compute\\Message\\RevisionMessage"
WIKIRECENTCHANGES_RABBITMQ_COLLECT_TYPE ?= "App\\\\WikiRecentChanges\\\\Collect\\\\Message\\\\RecentChangeMessage"
WIKIRECENTCHANGES_RABBITMQ_COMPUTE_TYPE ?= "App\\\\WikiRecentChanges\\\\Compute\\\\Message\\\\RevisionMessage"
WIKIRECENTCHANGES_RABBITMQ_FORMAT ?= "pretty_json"
WIKIRECENTCHANGES_CONTENT_TYPE ?= "application/json"

.PHONY: help up realup build down reload ps
.PHONY: asynctask-create-topic asynctask-topic-consumer asynctask-exec-consume asynctask-start-api
.PHONY: wikirecentchangeskafka-compute-topic-consumer wikirecentchangeskafka-collect-topic-consumer wikirecentchangeskafka-collect-topic-producer wikirecentchangeskafka-compute-topic-producer wikirecentchangeskafka-exec-collect wikirecentchangeskafka-exec-store wikirecentchangeskafka-start-api
.PHONY: wikirecentchangesrabbitmq-compute-topic-consumer wikirecentchangesrabbitmq-collect-topic-consumer wikirecentchangesrabbitmq-collect-topic-producer wikirecentchangesrabbitmq-compute-topic-producer wikirecentchangesrabbitmq-exec-collect wikirecentchangesrabbitmq-exec-store wikirecentchangesrabbitmq-start-api
.PHONY: wikirecentchangesmongo-compute-topic-consumer wikirecentchangesmongo-collect-topic-consumer wikirecentchangesmongo-collect-topic-producer wikirecentchangesmongo-compute-topic-producer wikirecentchangesmongo-exec-collect wikirecentchangesmongo-exec-store wikirecentchangesmongo-start-api
.PHONY: singlecomputedev-collect-consumer singlecomputedev-compute-consumer singlecomputedev-producer singlecomputedev-exec singlecomputelocal-exec
.PHONY: go-library-bundle test-library-bundle phpunit-library-bundle phpcs-library-bundle
.PHONY: go-http-transport-bundle test-http-transport-bundle phpunit-http-transport-bundle phpcs-http-transport-bundle
.PHONY: go-doctrine-transport-bundle test-doctrine-transport-bundle phpunit-doctrine-transport-bundle phpcs-doctrine-transport-bundle
.PHONY: go-healthcheck-bundle test-healthcheck-bundle phpunit-healthcheck-bundle phpcs-healthcheck-bundle
.PHONY: go-prometheus-bundle test-prometheus-bundle phpunit-prometheus-bundle phpcs-prometheus-bundle
.PHONY: go-version-bundle test-version-bundle phpunit-version-bundle phpcs-version-bundle
.PHONY: install-app go-source go-kafka

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


############################################
### VdmLibraryDoctrineTransportBundle ###
############################################
go-doctrine-transport-bundle:
	@docker exec -it  vdm_dev_doctrine_transport_bundle /bin/bash

test-doctrine-transport-bundle: phpcs-doctrine-transport-bundle phpunit-doctrine-transport-bundle

phpunit-doctrine-transport-bundle:
	@docker-compose exec vdm_dev_doctrine_transport_bundle php -d memory_limit=-1 vendor/phpunit/phpunit/phpunit Tests/

phpcs-doctrine-transport-bundle:
	@docker-compose exec vdm_dev_doctrine_transport_bundle php -d memory_limit=-1 vendor/bin/phpcs --ignore=vendor/ --standard=PSR12 .


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


###########################
### VdmVersionBundle ###
###########################
go-version-bundle:
	@docker exec -it  vdm_dev_version_bundle /bin/bash

test-version-bundle: phpcs-version-bundle phpunit-version-bundle

phpunit-version-bundle:
	@docker-compose exec vdm_dev_version_bundle php -d memory_limit=-1 ./vendor/bin/phpunit

phpcs-version-bundle:
	@docker-compose exec vdm_dev_version_bundle php -d memory_limit=-1 vendor/bin/phpcs --ignore=vendor/ --standard=PSR12 .


#########################################
### wikirecentchanges kafka shortcuts ###
#########################################
wikirecentchangeskafka-collect-topic-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t wikirecentchanges

#@docker-compose exec vdm_dev_kafka /usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic wikirecentchanges_enriched --from-beginning --property print.key=true --property print.headers=true --property print.timestamp=true
wikirecentchangeskafka-compute-topic-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t wikirecentchanges_enriched

wikirecentchangeskafka-collect-topic-producer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -P -H "type=${WIKIRECENTCHANGES_KAFKA_COLLECT_TYPE}" -H "Content-Type=${WIKIRECENTCHANGES_CONTENT_TYPE}" -t wikirecentchanges

wikirecentchangeskafka-compute-topic-producer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -P -H "type=${WIKIRECENTCHANGES_KAFKA_COMPUTE_TYPE}" -H "Content-Type=${WIKIRECENTCHANGES_CONTENT_TYPE}" -t wikirecentchanges_enriched

wikirecentchangeskafka-exec-collect:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-collect vdm_dev_app bin/console --env=wikirecentchangeskafka vdm:collect wiki-collect-get -vvv

wikirecentchangeskafka-exec-compute:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-compute vdm_dev_app bin/console --env=wikirecentchangeskafka vdm:consume wiki-compute-get -vvv

wikirecentchangeskafka-exec-store:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-store vdm_dev_app bin/console --env=wikirecentchangeskafka vdm:consume wiki-store-get -vvv

wikirecentchangeskafka-start-api:
	@echo "----\nlistening on http://127.0.0.1:4000\n----\n\n"
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-api -e APP_ENV=wikirecentchangeskafka vdm_dev_app php -S 0.0.0.0:80 -t public/


############################################
### wikirecentchanges rabbitmq shortcuts ###
############################################
wikirecentchangesrabbitmq-collect-topic-consumer:
	@docker-compose exec vdm_dev_rabbitmq rabbitmqadmin --format=${WIKIRECENTCHANGES_RABBITMQ_FORMAT} get queue=wikirecentchanges

wikirecentchangesrabbitmq-compute-topic-consumer:
	@docker-compose exec vdm_dev_rabbitmq rabbitmqadmin --format=${WIKIRECENTCHANGES_RABBITMQ_FORMAT} get queue=wikirecentchanges_enriched

wikirecentchangesrabbitmq-collect-topic-producer:
	@docker-compose exec vdm_dev_rabbitmq rabbitmqadmin publish exchange=wikirecentchanges routing_key='' properties="{\"content_type\":\"${WIKIRECENTCHANGES_CONTENT_TYPE}\",\"headers\":{\"type\":\"${WIKIRECENTCHANGES_RABBITMQ_COLLECT_TYPE}\"}}"

wikirecentchangesrabbitmq-compute-topic-producer:
	@docker-compose exec vdm_dev_rabbitmq rabbitmqadmin publish exchange=wikirecentchanges_enriched routing_key='' properties="{\"content_type\":\"${WIKIRECENTCHANGES_CONTENT_TYPE}\",\"headers\":{\"type\":\"${WIKIRECENTCHANGES_RABBITMQ_COMPUTE_TYPE}\"}}"

wikirecentchangesrabbitmq-exec-collect:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-collect vdm_dev_app bin/console --env=wikirecentchangesrabbitmq vdm:collect wiki-collect-get -vvv

wikirecentchangesrabbitmq-exec-compute:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-compute vdm_dev_app bin/console --env=wikirecentchangesrabbitmq vdm:consume wiki-compute-get -vvv

wikirecentchangesrabbitmq-exec-store:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-store vdm_dev_app bin/console --env=wikirecentchangesrabbitmq vdm:consume wiki-store-get -vvv

wikirecentchangesrabbitmq-start-api:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-api -e APP_ENV=wikirecentchangesrabbitmq vdm_dev_app php -S 0.0.0.0:80 -t public/


#########################################
### wikirecentchanges mongo shortcuts ###
#########################################
wikirecentchangesmongo-collect-topic-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t wikirecentchanges

wikirecentchangesmongo-compute-topic-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t wikirecentchanges_enriched

wikirecentchangesmongo-collect-topic-producer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -P -H "type=${WIKIRECENTCHANGES_KAFKA_COLLECT_TYPE}" -H "Content-Type=${WIKIRECENTCHANGES_CONTENT_TYPE}" -t wikirecentchanges

wikirecentchangesmongo-compute-topic-producer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -P -H "type=${WIKIRECENTCHANGES_KAFKA_COMPUTE_TYPE}" -H "Content-Type=${WIKIRECENTCHANGES_CONTENT_TYPE}" -t wikirecentchanges_enriched

wikirecentchangesmongo-exec-collect:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-collect vdm_dev_app bin/console --env=wikirecentchangesmongo vdm:collect wiki-collect-get -vvv

wikirecentchangesmongo-exec-compute:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-compute vdm_dev_app bin/console --env=wikirecentchangesmongo vdm:consume wiki-compute-get -vvv

wikirecentchangesmongo-exec-store:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-store vdm_dev_app bin/console --env=wikirecentchangesmongo vdm:consume wiki-store-get -vvv

wikirecentchangesmongo-start-api:
	@echo "----\nlistening on http://127.0.0.1:4000\n----\n\n"
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-wikirecentchanges-api -e APP_ENV=wikirecentchangesmongo vdm_dev_app php -S 0.0.0.0:80 -t public/


###########################
### asynctask shortcuts ###
###########################
asynctask-create-topic:
	@docker-compose exec vdm_dev_kafka kafka-topics --create --if-not-exists --bootstrap-server vdm_dev_kafka:29092 --replication-factor 1 --partitions 1 --topic asynctask

asynctask-topic-consumer:
	@docker-compose exec vdm_dev_kafkacat kafkacat -b vdm_dev_kafka:29092 -C -f '\nKey (%K bytes): %k\t\nValue (%S bytes): %s\nPartition: %p\t\nOffset: %o\nHeaders: %h\n--\n' -t asynctask

asynctask-exec-consume:
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-asynctask-consumer vdm_dev_app bin/console --env=asynctask vdm:consume async-task -vvv

asynctask-start-api:
	@echo "----\nlistening on http://127.0.0.1:4000\n----\n\n"
	@docker-compose exec -e VDM_APP_NAME=vdm-dev-env-asynctask-api -e APP_ENV=asynctask vdm_dev_app php -S 0.0.0.0:80 -t public/


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

go-kafka:
	@docker exec -it  vdm_dev_kafka /bin/bash