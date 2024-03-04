#!/bin/bash

# remind to source instead of just running
echo "Run this script using the following command: source ./approve_chaincode.sh because it sets environment variables."

# 1. Ensure chaincode is installed on this peer
peer lifecycle chaincode queryinstalled

# 2. Get package ID of chaincode to approve
read -p "1/5. Enter the package ID of the relevant chaincode from above: " package_id
# Save package ID to environment variable
export CC_PACKAGE_ID="$package_id"

# 3. Get more details for approval
read -p "2/5. Enter the channel ID: " channel_id
read -p "3/5. Enter the chaincode name: " chaincode_name
read -p "4/5. Finally, enter the chaincode version: " chaincode_version
read -p "5/5. Finally, enter the chaincode sequence: " chaincode_sequence

# 4. Approve chaincode for this org
peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID "$channel_id" --name "$chaincode_name" --version "$chaincode_version" --package-id $CC_PACKAGE_ID --sequence "$chaincode_sequence" --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

# 3. Remind to do for all peers
echo -e "\n If successful, repeat the above command for all peers that will endorse transactions."