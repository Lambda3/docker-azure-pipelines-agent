#!/bin/bash

if [ -z $DOCKER_USERNAME ]; then
  >&2 echo 'Variable "$DOCKER_USERNAME" is not set.'
  exit 3
fi
if [ -z $DOCKER_PASSWORD ]; then
  >&2 echo 'Variable "$DOCKER_PASSWORD" is not set.'
  exit 4
fi
if [ ! -f $HOME/.docker/config.json ]; then
  if [ -z $DOCKER_SERVER ]; then
    echo 'Login in to docker.com'
    sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  else
    echo "Login in to $DOCKER_SERVER"
    sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_SERVER
  fi
fi
unset DOCKER_USERNAME
unset DOCKER_PASSWORD
export DOCKER_VERSION=$(docker --version)
export DOCKER_COMPOSE_VERSION=$(docker-compose --version)
