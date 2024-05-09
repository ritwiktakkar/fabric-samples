#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0




# default to using Retailer
ORG=${1:-Retailer}

# Exit on first error, print all commands.
set -e
set -o pipefail

# Where am I?
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

ORDERER_CA=${DIR}/test-network/organizations/ordererOrganizations/.com/tlsca/tlsca..com-cert.pem
PEER0_RETAILER_CA=${DIR}/test-network/organizations/peerOrganizations/retailer.com/tlsca/tlsca.retailer.com-cert.pem
PEER0_BUYINGAGENT_CA=${DIR}/test-network/organizations/peerOrganizations/buyingagent.com/tlsca/tlsca.buyingagent.com-cert.pem
PEER0_FPS_CA=${DIR}/test-network/organizations/peerOrganizations/fps..com/tlsca/tlsca.fps..com-cert.pem


if [[ ${ORG,,} == "retailer" || ${ORG,,} == "digibank" ]]; then

   CORE_PEER_LOCALMSPID=RetailerMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/retailer.com/users/Admin@retailer.com/msp
   CORE_PEER_ADDRESS=localhost:7051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/retailer.com/tlsca/tlsca.retailer.com-cert.pem

elif [[ ${ORG,,} == "buyingagent" || ${ORG,,} == "magnetocorp" ]]; then

   CORE_PEER_LOCALMSPID=BuyingAgentMSP
   CORE_PEER_MSPCONFIGPATH=${DIR}/test-network/organizations/peerOrganizations/buyingagent.com/users/Admin@buyingagent.com/msp
   CORE_PEER_ADDRESS=localhost:9051
   CORE_PEER_TLS_ROOTCERT_FILE=${DIR}/test-network/organizations/peerOrganizations/buyingagent.com/tlsca/tlsca.buyingagent.com-cert.pem

else
   echo "Unknown \"$ORG\", please choose Retailer/Digibank or BuyingAgent/Magnetocorp"
   echo "For example to get the environment variables to set upa BuyingAgent shell environment run:  ./setOrgEnv.sh BuyingAgent"
   echo
   echo "This can be automated to set them as well with:"
   echo
   echo 'export $(./setOrgEnv.sh BuyingAgent | xargs)'
   exit 1
fi

# output the variables that need to be set
echo "CORE_PEER_TLS_ENABLED=true"
echo "ORDERER_CA=${ORDERER_CA}"
echo "PEER0_RETAILER_CA=${PEER0_RETAILER_CA}"
echo "PEER0_BUYINGAGENT_CA=${PEER0_BUYINGAGENT_CA}"
echo "PEER0_FPS_CA=${PEER0_FPS_CA}"

echo "CORE_PEER_MSPCONFIGPATH=${CORE_PEER_MSPCONFIGPATH}"
echo "CORE_PEER_ADDRESS=${CORE_PEER_ADDRESS}"
echo "CORE_PEER_TLS_ROOTCERT_FILE=${CORE_PEER_TLS_ROOTCERT_FILE}"

echo "CORE_PEER_LOCALMSPID=${CORE_PEER_LOCALMSPID}"
