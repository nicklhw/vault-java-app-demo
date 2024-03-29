.DEFAULT_GOAL := all
.PHONY: clean up-detach init show-members ui token

export VAULT_ADDR := http://localhost:8200

all: clean up-detach init

up-detach:
	cd docker-compose \
	  && docker-compose --profile backend up --detach

init:
	cd docker-compose/scripts \
	  && ./init.sh

clean:
	cd docker-compose \
	&& docker-compose down --volumes --remove-orphans \
	&& rm -f ./scripts/vault.json

show-members:
	vault operator raft list-peers

logs:
	cd docker-compose \
    && docker-compose logs -f

ui:
	open http://localhost:8200

build-app:
	cd spring-vault-demo \
	&& ./mvnw clean package

run-app:
	cd spring-vault-demo \
	&& ./mvnw spring-boot:run

build-docker-app:
	docker build -t nicklhw/spring-vault-demo -f spring-vault-demo/Dockerfile ./spring-vault-demo