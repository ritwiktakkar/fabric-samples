#!/bin/bash

# Prompt user for confirmation
read -p "Are you sure you want to RESET the network? ALL Docker containers/volumes will be DELETED (default: NO): " answer

# Check user's answer
if [ "$answer" = "YES" ]; then
    echo "Deleting all Docker containers..."
    docker rm -f $(docker ps -aq)
    echo "Deleting all Docker volumes..."
    docker volume ls -q | xargs docker volume rm
    echo "All Docker containers and volumes have been deleted."
else
    echo "Operation cancelled. Network has NOT been reset."
fi