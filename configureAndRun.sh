#!/bin/bash

trap '{ pid=$(pgrep Agent.Listener); kill -2 $pid; while kill -0 $pid 2> /dev/null; do sleep 1; done; echo "Agent stopped."; exit 0; }' SIGTERM
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

check () {
  retval=$1
  if [ $retval -ne 0 ]; then
      >&2 echo "Return code was not zero but $retval"
      exit 999
  fi
}

ifRun () {
  file=$DIR/$1
  if [ -f $file ]; then
    . $file
  fi
}

echo Starting configuration for $(hostname)...
ifRun preConfigure.sh
. $DIR/configureAgent.sh
ifRun postConfigure.sh
echo Configuration done. Starting run for $(hostname)...
ifRun preRun.sh
. $DIR/runAgent.sh
ifRun postRun.sh
exit 0
