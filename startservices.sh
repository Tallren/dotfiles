#!/bin/bash
################
# This script starts services using brew services command
################
services="borders sketchybar"

for service in $services; do
    echo "Starting service $service and setting to run at system startup"
    brew services start $service
    echo "done"
done

echo "All services have been started"
