#!/bin/bash

export DOTNET_VERSION=$(dotnet --version)
cd $DIR
$DIR/bin/Agent.Listener run &
wait
exit 0
