#!/bin/bash

if [ ! -f $HOME/.docker/config.json ] && [ ! -z $DOCKER_USERNAME ] && [ ! -z $DOCKER_PASSWORD ]; then
  if [ -z $DOCKER_SERVER ]; then
    echo 'Login in to docker.com'
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  else
    echo "Login in to $DOCKER_SERVER"
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_SERVER
  fi
  unset DOCKER_USERNAME
  unset DOCKER_PASSWORD
fi
export DOCKER_VERSION=$(docker --version)
export DOCKER_COMPOSE_VERSION=$(docker-compose --version)
