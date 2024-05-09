#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

function createRawMaterials {
	infoln "Enrolling the CA admin"
	mkdir -p ../organizations/peerOrganizations/rawmaterials.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/rawmaterials.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-rawmaterials --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-rawmaterials.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-rawmaterials.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-rawmaterials.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-rawmaterials.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/../organizations/peerOrganizations/rawmaterials.com/msp/config.yaml"

	infoln "Registering peer0"
  set -x
	fabric-ca-client register --caname ca-rawmaterials --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-rawmaterials --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-rawmaterials --id.name rawmaterialsadmin --id.secret rawmaterialsadminpw --id.type admin --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-rawmaterials -M "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/msp" --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-rawmaterials -M "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls" --enrollment.profile tls --csr.hosts peer0.rawmaterials.com --csr.hosts localhost --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null


  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/ca.crt"
  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/signcerts/"* "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/server.crt"
  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/keystore/"* "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/server.key"

  mkdir "${PWD}/../organizations/peerOrganizations/rawmaterials.com/msp/tlscacerts"
  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/rawmaterials.com/msp/tlscacerts/ca.crt"

  mkdir "${PWD}/../organizations/peerOrganizations/rawmaterials.com/tlsca"
  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/rawmaterials.com/tlsca/tlsca.rawmaterials.com-cert.pem"

  mkdir "${PWD}/../organizations/peerOrganizations/rawmaterials.com/ca"
  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/peers/peer0.rawmaterials.com/msp/cacerts/"* "${PWD}/../organizations/peerOrganizations/rawmaterials.com/ca/ca.rawmaterials.com-cert.pem"

  infoln "Generating the user msp"
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-rawmaterials -M "${PWD}/../organizations/peerOrganizations/rawmaterials.com/users/User1@rawmaterials.com/msp" --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/rawmaterials.com/users/User1@rawmaterials.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
	fabric-ca-client enroll -u https://rawmaterialsadmin:rawmaterialsadminpw@localhost:11054 --caname ca-rawmaterials -M "${PWD}/../organizations/peerOrganizations/rawmaterials.com/users/Admin@rawmaterials.com/msp" --tls.certfiles "${PWD}/fabric-ca/rawmaterials/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/rawmaterials.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/rawmaterials.com/users/Admin@rawmaterials.com/msp/config.yaml"
}
