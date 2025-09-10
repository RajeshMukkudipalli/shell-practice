#!/bin/bash

while true; do
    Cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    echo "Current CPU Usage: $Cpu_usage%"
    sleep 1
done