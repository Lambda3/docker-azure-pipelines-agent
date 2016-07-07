#!/bin/bash

trap '{ pid=$(pgrep Agent.Listener); kill -2 $pid; while kill -0 $pid 2> /dev/null; do sleep 1; done; echo "Agent stopped."; exit 0; }' SIGTERM
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/configureAgent.sh
. $DIR/runAgent.sh
