#!/bin/bash

# remind to source instead of just running
echo "Run this script using the following command: source ./simulate_peer.sh because it sets environment variables."

# bring cli container into context of current session
export PATH="$(dirname "$(pwd)")/bin:$PATH"
export FABRIC_CFG_PATH="$(dirname "$(pwd)")/config/"

# source env vars
source ./scripts/envVar.sh

# choose which org to simulate
read -p "Enter org number of peer to simulate (check envVar.sh): " org_num
setGlobals $org_num