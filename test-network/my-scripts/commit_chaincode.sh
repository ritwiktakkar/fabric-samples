#!/bin/bash

# After a sufficient number (e.g., default endorsement policy dictates majority users) of organizations have approved a chaincode definition, one organization can commit the chaincode definition to the channel. If a majority of channel members have approved the definition, the commit transaction will be successful and the parameters agreed to in the chaincode definition will be implemented on the channel.

# 1. Check commitreadiness 
echo "Checking commit readiness..."
read -p "Enter the chaincode version: " chaincode_version
read -p "Enter the sequence: " chaincode_sequence
peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name basic --version "$chaincode_version" --sequence "$chaincode_sequence" --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --output json

# 2. Commit chaincode definition to channel
read -p "Reminder: Only one org needs to commit the chaincode definition to the channel. The current org MSP is $CORE_PEER_LOCALMSPID. Press any key to continue or ctrl+c to abort..."

# 3. Get more details to commit
read -p "Enter the channel ID: " channel_id
read -p "Enter the chaincode name: " chaincode_name
echo -e "\n"
read -p "Finally, enter peer addresses and tlsRootCertFiles paths to target a sufficient number of organizations to meet chaincode endorsement policy (e.g., --peerAddresses localhost:7051 --tlsRootCertFiles "\${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "\${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt"): " peer_addresses_and_tls_root_cert_files

# 4. Commit chaincode
peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID "$channel_id" --name "$chaincode_name" --version "$chaincode_version" --sequence "$chaincode_sequence" --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" "$peer_addresses_and_tls_root_cert_files"

# 5. Check if chaincode is committed
echo -e "\nChecking if chaincode is committed:"
peer lifecycle chaincode querycommitted --channelID mychannel --name basic --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
echo -e "\nIf the sequence and version of the chaincode definition is listed above then the chaincode definition has been committed to the channel. If not, then the commit transaction was not successful."