#!/bin/bash

while true; do
    Mem_usage=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')
    echo "Current Memory Usage: $Mem_usage%"
    sleep 1
done