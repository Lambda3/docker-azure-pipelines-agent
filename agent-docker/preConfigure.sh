#!/bin/bash

set -eo pipefail

if ! docker info | grep 'Docker for Windows' > /dev/null; then
  DOCKER_INTERNAL_HOST="host.docker.internal"
  if ! grep $DOCKER_INTERNAL_HOST /etc/hosts > /dev/null; then
    DOCKER_INTERNAL_IP=`/sbin/ip route | awk '/default/ { print $3 }' | awk '!seen[$0]++'`
    echo -e "$DOCKER_INTERNAL_IP\t$DOCKER_INTERNAL_HOST" | sudo tee --append /etc/hosts > /dev/null
    echo "Added $DOCKER_INTERNAL_IP to /etc/hosts as $DOCKER_INTERNAL_HOST"
  fi
fi
sudo chown agentuser:agentuser /var/run/docker.sock
if [ ! -f $HOME/.docker/config.json ] && [ ! -z $DOCKER_USERNAME ] && [ ! -z $DOCKER_PASSWORD ]; then
  if [ -z $DOCKER_SERVER ]; then
    echo 'Login in to docker.com'
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  else
    echo "Login in to $DOCKER_SERVER"
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_SERVER
  fi
  sudo chown -R agentuser:agentuser /home/agentuser/.docker/
fi
unset DOCKER_USERNAME
unset DOCKER_PASSWORD
export DOCKER_VERSION=$(docker --version)
export DOCKER_COMPOSE_VERSION=$(docker-compose --version)
