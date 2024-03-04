#!/bin/bash

# 1. Ensure chaincode is installed on each peer that will endorse transactions
echo -e "Chaincode must be installed on each peer that will endorse transactions based on endorsement policy. Ensure that the user has already been set prior to continuing, and if not, use the set_user.txt file to do so...\n"
read -p "Press any key to continue or ctrl+c to abort..."

# 2. Install chaincode on peer
echo "Running: peer lifecycle chaincode install basic.tar.gz"
peer lifecycle chaincode install basic.tar.gz

# 3. Remind to do for all peers
echo -e "\n If successful, repeat the above command for all peers that will endorse transactions."