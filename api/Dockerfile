# pull official base image
FROM python:3.8-slim


ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update -y && \
    apt-get install postgresql postgresql-contrib gcc python3-dev musl-dev postgresql-client netcat -y

RUN useradd -ms /bin/bash jokea

ENV APP_HOME=/code/

RUN mkdir -p $APP_HOME

COPY . $APP_HOME

RUN pip3 install --upgrade pip

COPY ./requirements.txt $APP_HOME
COPY ./entrypoint.sh $APP_HOME

RUN pip3 install -r $APP_HOME/requirements.txt

RUN mkdir -p $APP_HOME/staticfiles

WORKDIR $APP_HOME


RUN chown -R jokea:jokea $APP_HOME

USER jokea


ENTRYPOINT ["/code/entrypoint.sh"]