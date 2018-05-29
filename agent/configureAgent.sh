#!/bin/bash

if [ -z $AGENT_POOL ]; then AGENT_POOL=Default; fi
if [ -z $VS_TENANT ]; then
  >&2 echo 'Variable "$VS_TENANT" is not set.'
  exit 1
fi
if [ -z $AGENT_PAT ]; then
  >&2 echo 'Variable "$AGENT_PAT" is not set.'
  exit 2
fi
if [ ! -f $DIR/.credentials ]; then
  vs_tenant=$VS_TENANT
  agent_pool=$AGENT_POOL
  agent_pat=$AGENT_PAT
  unset AGENT_PAT
  unset AGENT_POOL
  unset VS_TENANT
  export DOTNET_VERSION=$(dotnet --version)
  work_dir="$DIR/_works/$(hostname)"
  if ! [ -d $work_dir ]; then
    sudo mkdir -p $work_dir
  fi
  $DIR/bin/Agent.Listener configure --url https://$vs_tenant.visualstudio.com --pool $agent_pool --auth PAT --token $agent_pat --agent $(hostname) --work $work_dir --unattended
  check $?
fi
