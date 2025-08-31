#!/bin/bash

greet="Hello Good Morning"
echo "$greet"
echo "process id of script-1 is pid-1 $$"

#./script-2.sh here both the script will run in different process id and they can't access each other's variables

source ./script-2.sh  # here both the script will run in same process id and they can access each other's variables