#!/bin/bash

# Prompt user for channel name
read -p "Enter channel name: " channel_name

# Run the command with the provided channel name
./network.sh up createChannel -ca -c "$channel_name"