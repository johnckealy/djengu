FROM python:3.8-slim

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV APP_HOME=/home/python_user/code

RUN apt-get update -y && \
    apt-get install postgresql \
    postgresql-contrib \
    gcc \
    python3-dev \
    musl-dev \
    postgresql-client \
    netcat -y


# RUN mkdir -p $APP_HOME
RUN useradd -ms /bin/bash python_user
RUN mkdir -p $APP_HOME/staticfiles
RUN chown -R python_user:python_user $APP_HOME
COPY . $APP_HOME

ENV PATH="/home/python_user/.local/bin:$PATH"

USER python_user
WORKDIR $APP_HOME

RUN pip install --no-cache-dir --upgrade pip
RUN pip install -r $APP_HOME/requirements.txt

ENTRYPOINT ["/home/python_user/code/entrypoint.sh"]