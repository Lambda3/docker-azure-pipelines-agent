#!/bin/bash

trap '{ pid=$(pgrep Agent.Listener); kill -2 $pid; while kill -0 $pid 2> /dev/null; do sleep 1; done; echo "Agent stopped."; exit 0; }' SIGTERM
cd /agent
export DOTNET_VERSION=$(dotnet --version)
if [ -z $AGENT_POOL ]; then AGENT_POOL=Default; fi
if [ -z $VS_TENANT ]; then
  >&2 echo 'Variable "$VS_TENANT" is not set.'
  exit 1
fi
if [ -z $AGENT_PAT ]; then
  >&2 echo 'Variable "$AGENT_PAT" is not set.'
  exit 2
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ ! -f $DIR/.credentials ]; then
  $DIR/bin/Agent.Listener configure --url https://$VS_TENANT.visualstudio.com --pool $AGENT_POOL --auth PAT --token $AGENT_PAT --agent $(hostname) --unattended
fi
unset AGENT_PAT
unset AGENT_POOL
unset VS_TENANT
$DIR/bin/Agent.Listener run &
wait
exit 0
