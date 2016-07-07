#!/bin/bash

cd $DIR
$DIR/bin/Agent.Listener run &
wait
