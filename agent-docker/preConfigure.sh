#!/bin/bash

if [ -z $DOCKER_USERNAME ]; then
  >&2 echo 'Variable "$DOCKER_USERNAME" is not set.'
  exit 3
fi
if [ -z $DOCKER_PASSWORD ]; then
  >&2 echo 'Variable "$DOCKER_PASSWORD" is not set.'
  exit 4
fi
sudo chown agentuser:agentuser /var/run/docker.sock
if [ ! -f $HOME/.docker/config.json ]; then /agent/dockerLogin.exp; fi
unset DOCKER_USERNAME
unset DOCKER_PASSWORD
export DOCKER_VERSION=$(docker --version)
export DOCKER_COMPOSE_VERSION=$(docker-compose --version)
