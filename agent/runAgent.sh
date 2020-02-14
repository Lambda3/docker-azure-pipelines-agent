#!/bin/bash

if [ "$DEBUG" == 'true' ]; then
  set -x
fi
set -eo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

trap cleanup SIGINT

cleanup() {
  if [ -d /proc/$pid ]; then
    echo "Killing agent..."
    disown $pid
    kill -9 $pid
  else
    echo "Agent process not found, exiting directly."
  fi
  exit 0
}

cd $DIR
if [ -f $DIR/exiting ]; then
  rm $DIR/exiting
fi
$DIR/bin/Agent.Listener run &
pid=$!
while :; do
  while ps aux | grep --color=never [A]gent > /dev/null; do
    sleep 10
  done
  echo "Agent was stopped."
  if [ -f $DIR/exiting ]; then
    echo "Not restaring agent, we are exiting."
    exit 0
  else
    echo "Restaring agent..."
  fi
  $DIR/bin/Agent.Listener run &
  pid=$!
done
