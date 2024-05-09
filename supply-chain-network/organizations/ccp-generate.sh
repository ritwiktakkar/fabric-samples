#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=7051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/retailer.com/tlsca/tlsca.retailer.com-cert.pem
CAPEM=organizations/peerOrganizations/retailer.com/ca/ca.retailer.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/retailer.com/connection-retailer.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/retailer.com/connection-retailer.yaml

ORG=2
P0PORT=9051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/buyingagent.com/tlsca/tlsca.buyingagent.com-cert.pem
CAPEM=organizations/peerOrganizations/buyingagent.com/ca/ca.buyingagent.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/buyingagent.com/connection-buyingagent.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/buyingagent.com/connection-buyingagent.yaml

ORG=3
P0PORT=11051
# CAPORT=8054
PEERPEM=organizations/peerOrganizations/auditor.com/tlsca/tlsca.auditor.com-cert.pem
CAPEM=organizations/peerOrganizations/auditor.com/ca/ca.auditor.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/auditor.com/connection-auditor.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/auditor.com/connection-auditor.yaml

ORG=4
P0PORT=12051
# CAPORT=8054
PEERPEM=organizations/peerOrganizations/fullpackagesupplier.com/tlsca/tlsca.fullpackagesupplier.com-cert.pem
CAPEM=organizations/peerOrganizations/fullpackagesupplier.com/ca/ca.fullpackagesupplier.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/fullpackagesupplier.com/connection-fullpackagesupplier.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/fullpackagesupplier.com/connection-fullpackagesupplier.yaml

ORG=5
P0PORT=13051
# CAPORT=8054
PEERPEM=organizations/peerOrganizations/rawmaterialssupplier.com/tlsca/tlsca.rawmaterialssupplier.com-cert.pem
CAPEM=organizations/peerOrganizations/rawmaterialssupplier.com/ca/ca.rawmaterialssupplier.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/rawmaterialssupplier.com/connection-rawmaterialssupplier.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/rawmaterialssupplier.com/connection-rawmaterialssupplier.yaml

ORG=6
P0PORT=14051
# CAPORT=8054
PEERPEM=organizations/peerOrganizations/textilemanufacturer.com/tlsca/tlsca.textilemanufacturer.com-cert.pem
CAPEM=organizations/peerOrganizations/textilemanufacturer.com/ca/ca.textilemanufacturer.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/textilemanufacturer.com/connection-textilemanufacturer.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/textilemanufacturer.com/connection-textilemanufacturer.yaml
