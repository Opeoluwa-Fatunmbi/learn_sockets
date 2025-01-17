ifneq (,$(wildcard ./.env))
include .env
export 
ENV_FILE_PARAM = --env-file .env

endif
act:
	source env/Scripts/activate

build:
	docker-compose up --build -d --remove-orphans

up:
	docker-compose up -d

down:
	docker-compose down

show-logs:
	docker-compose logs

serv:
	python manage.py runserver

purge:
	pip cache purge

userv:
	uvicorn learn_sockets.asgi:application --reload
	
mmig: # run with "make mmig" or "make mmig app='app'"
	if [ -z "$(app)" ]; then \
		python manage.py makemigrations; \
	else \
		python manage.py makemigrations "$(app)"; \
	fi

mig: # run with "make mig" or "make mig app='app'"
	if [ -z "$(app)" ]; then \
		python manage.py migrate; \
	else \
		python manage.py migrate "$(app)"; \
	fi

init:
	python manage.py initial_data
	
test:
	pytest --disable-warnings -vv -x

shell:
	python manage.py shell

suser:
	python manage.py createsuperuser

cpass:
	python manage.py changepassword
	
reqm: # Install requirements
	pip install -r requirements.txt

ureqm: # Update requirements
	pip freeze > requirements.txt

secretk:
	python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"