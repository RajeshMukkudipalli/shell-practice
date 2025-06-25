#!/bin/bash

echo "All variables passed to the script: $@"
echo "Number of variables: $#"
echo "script name: $0"
echo "current directory: $PWD"
echo "user currently executing this script: $USER"
echo "Home directory of the user: $HOME"
echo "process ID of the current script: $$"
sleep 10 &
echo "process id of the last background command: $!"