FROM python:3.8-slim


# set work directory
WORKDIR /usr/src

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Postgres
RUN apt-get update && \
    apt-get install postgresql postgresql-contrib gcc python3-dev musl-dev postgresql-client -y

RUN useradd -ms /bin/bash jokea

# install dependencies
RUN pip3 install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN chown -R jokea:jokea .

USER jokea


ENTRYPOINT ["/usr/src/entrypoint.sh"]

