#!/bin/bash

# 1. Ensure chaincode dependencies are installed
echo -e "First, navigate to folder that contains the Go code and ensure smart contract dependencies are installed ('GO111MODULE=on go mod vendor').\n"

# 2. Package chaincode using peer CLI
echo "Next, package the smart contract to form chaincode using a PEER CLI (i.e., 'peer version' command should work): here we go..."
read -p "1/4. Enter chaincode package name: " chaincode_package_name
read -p "2/4. Enter smart contract code path (e.g., '../asset-transfer-basic/chaincode-go/'): " sc_code_path
read -p "3/4. Enter chaincode language (default=golang): " chaincode_language
# Set default value if user input is empty
if [ -z "$chaincode_language" ]; then
    chaincode_language="golang"
fi
read -p "4/4. Finally, enter a chaincode label to identify it later (use name_version): " chaincode_version

# 3. Run the command to package chaincode
echo -e "\nPackaging chaincode..."
peer lifecycle chaincode package "$chaincode_package_name".tar.gz --path "$sc_code_path" --lang "$chaincode_language" --label "$chaincode_version"


