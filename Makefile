PYTHON=python3.8
DJANGO_MANAGE=api/manage.py
ENV_DIR=.$(PYTHON)_env
IN_ENV=. $(ENV_DIR)/bin/activate

env-dev:
	$(eval include env/.env.dev)
	$(eval export $(shell sed 's/=.*//' env/.env.dev))

env-test:
	$(eval include env/.env.test)
	$(eval export $(shell sed 's/=.*//' env/.env.test))

env-staging:
	$(eval include env/.env.staging)
	$(eval export $(shell sed 's/=.*//' env/.env.staging))

env-prod:
	$(eval include env/.env.prod)
	$(eval export $(shell sed 's/=.*//' env/.env.prod))

celery: env-dev
	$(IN_ENV) && cd api && celery -A config worker --beat -l info -S django

deploy-prod: env-prod build-frontend
	echo "Building ${ENVIRONMENT} Environment"
	docker-compose -f docker-compose.prod.yml up --build -d

deploy-staging: env-staging build-frontend
	echo "Building ${ENVIRONMENT} Environment"
	docker-compose -f docker-compose.prod.yml up --build -d

docker-down: env-prod
	docker-compose -f docker-compose.staging.yml down

docker-logs: env-prod
	docker-compose -f docker-compose.staging.yml logs -f

build-python:
	virtualenv -p $(PYTHON) $(ENV_DIR)
	$(IN_ENV) && pip3 install -r api/requirements.txt

build-frontend:
	cd frontend && npm i && quasar build -m ssr

backend-serve: env-dev migrations
	$(IN_ENV) && python $(DJANGO_MANAGE) runserver

frontend-serve: env-dev
	cd frontend && quasar dev

frontend-prod-serve: env-prod
	cd frontend/dist/ssr/ && npm run start

run-django-scripts: env-dev
	@$(IN_ENV) && python $(DJANGO_MANAGE) runscript create_test_users

migrations: env-dev
	$(IN_ENV) && python $(DJANGO_MANAGE) makemigrations --noinput
	$(IN_ENV) && python $(DJANGO_MANAGE) migrate --noinput

flush-the-database-yes-really: env-dev
	$(IN_ENV) && python $(DJANGO_MANAGE) flush

test: env-test build-python
	$(IN_ENV) && $(PYTHON) -m pytest api/tests/

env-clean:
	@rm -rf $(ENV_DIR)
	@rm -rf node_modules frontend/node_modules
	@rm -rf package-lock.json frontend/package-lock.json
	@rm -rf frontend/dist
	@rm -rf .pytest_cache
	@echo "Environment cleaned."
