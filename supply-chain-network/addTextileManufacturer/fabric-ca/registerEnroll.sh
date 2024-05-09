#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

function createTextiles {
	infoln "Enrolling the CA admin"
	mkdir -p ../organizations/peerOrganizations/textile.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/textile.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-textile --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-textile.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-textile.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-textile.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-textile.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/../organizations/peerOrganizations/textile.com/msp/config.yaml"

	infoln "Registering peer0"
  set -x
	fabric-ca-client register --caname ca-textile --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-textile --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-textile --id.name textileadmin --id.secret textileadminpw --id.type admin --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-textile -M "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/msp" --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/textile.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-textile -M "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls" --enrollment.profile tls --csr.hosts peer0.textile.com --csr.hosts localhost --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null


  cp "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/ca.crt"
  cp "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/signcerts/"* "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/server.crt"
  cp "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/keystore/"* "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/server.key"

  mkdir "${PWD}/../organizations/peerOrganizations/textile.com/msp/tlscacerts"
  cp "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/textile.com/msp/tlscacerts/ca.crt"

  mkdir "${PWD}/../organizations/peerOrganizations/textile.com/tlsca"
  cp "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/textile.com/tlsca/tlsca.textile.com-cert.pem"

  mkdir "${PWD}/../organizations/peerOrganizations/textile.com/ca"
  cp "${PWD}/../organizations/peerOrganizations/textile.com/peers/peer0.textile.com/msp/cacerts/"* "${PWD}/../organizations/peerOrganizations/textile.com/ca/ca.textile.com-cert.pem"

  infoln "Generating the user msp"
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-textile -M "${PWD}/../organizations/peerOrganizations/textile.com/users/User1@textile.com/msp" --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/textile.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/textile.com/users/User1@textile.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
	fabric-ca-client enroll -u https://textileadmin:textileadminpw@localhost:11054 --caname ca-textile -M "${PWD}/../organizations/peerOrganizations/textile.com/users/Admin@textile.com/msp" --tls.certfiles "${PWD}/fabric-ca/textile/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/textile.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/textile.com/users/Admin@textile.com/msp/config.yaml"
}
