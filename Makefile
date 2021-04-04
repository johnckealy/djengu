SHELL := /bin/bash

PYTHON=python3.8
DJANGO_MANAGE=api/manage.py
ENV_DIR=.$(PYTHON)_env
IN_ENV=. $(ENV_DIR)/bin/activate

all:
	@./.djengu/create.sh

build-dev: env-dev build-python migrations run-django-scripts build-dev-frontend

build-python:
	virtualenv -p $(PYTHON) $(ENV_DIR)
	$(IN_ENV) && pip3 install -r api/requirements.txt

build-dev-frontend: env-dev
	@cd frontend && npm i && npx quasar build -m ssr

build-prod-frontend: env-prod
	@cd frontend && npm i && npx quasar build -m ssr

backend-serve: env-dev migrations
	$(IN_ENV) && python $(DJANGO_MANAGE) runserver

configure-vagrant:
	@sudo ./.djengu/.production_toolbox/vagrant_etchosts.sh
	@./.djengu/.production_toolbox/caddy/vagrant_caddy.sh

clean:
	@rm -rf $(ENV_DIR)
	@rm -rf node_modules frontend/node_modules
	@rm -rf package-lock.json frontend/package-lock.json
	@rm -rf frontend/dist frontend/src-ssr
	@rm -rf .pytest_cache
	@echo "Environment cleaned."

deploy: env-prod env-sub build-prod-frontend
	echo "Building ${ENVIRONMENT} Environment"
	docker-compose up --build

decrypt-dotenv: env-dev
	gpg --quiet --batch --yes --decrypt --passphrase=ENCRYPTION_KEY env.tar.gpg | tar -x

encrypt-dotenv:
	tar -c env/ | gpg --symmetric -c -o env.tar.gpg

env-dev:
	$(eval include env/.env.dev)
	$(eval export $(shell sed 's/=.*//' env/.env.dev))

env-test:
	$(eval include env/.env.test)
	$(eval export $(shell sed 's/=.*//' env/.env.test))

env-prod:
	$(eval include env/.env.prod)
	$(eval export $(shell sed 's/=.*//' env/.env.prod))

env-sub: env-prod
	@envsubst < "docker-compose.prod.yml" > "docker-compose.yml"

flush-the-database-yes-really: env-dev
	$(IN_ENV) && python $(DJANGO_MANAGE) flush

frontend-serve: env-dev
	cd frontend && npx quasar dev -m ssr

frontend-prod-serve: env-prod
	cd frontend/dist/ssr/ && npm run start

migrations: env-dev
	$(IN_ENV) && python $(DJANGO_MANAGE) makemigrations --noinput
	$(IN_ENV) && python $(DJANGO_MANAGE) migrate --noinput

run-django-scripts: env-dev
	@$(IN_ENV) && python $(DJANGO_MANAGE) runscript create_test_users

test: env-test build-python
	$(IN_ENV) && $(PYTHON) -m pytest api/tests/

test-build: env-test build-python build-dev-frontend
