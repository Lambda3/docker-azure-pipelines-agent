#!/bin/bash

set -eo pipefail

cd $DIR
$DIR/bin/Agent.Listener run &
