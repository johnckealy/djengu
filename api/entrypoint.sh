#!/bin/sh

set -e

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# python entry point commands go here
python manage.py migrate
python manage.py runscript create_test_users
python manage.py collectstatic --no-input

exec "$@"
