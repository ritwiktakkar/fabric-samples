#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

function createAuditor {
	infoln "Enrolling the CA admin"
	mkdir -p ../organizations/peerOrganizations/auditor.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/auditor.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-auditor --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-auditor.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-auditor.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-auditor.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-auditor.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/../organizations/peerOrganizations/auditor.com/msp/config.yaml"

	infoln "Registering peer0"
  set -x
	fabric-ca-client register --caname ca-auditor --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-auditor --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-auditor --id.name auditoradmin --id.secret auditoradminpw --id.type admin --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-auditor -M "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/msp" --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/auditor.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-auditor -M "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls" --enrollment.profile tls --csr.hosts peer0.auditor.com --csr.hosts localhost --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null


  cp "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/ca.crt"
  cp "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/signcerts/"* "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/server.crt"
  cp "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/keystore/"* "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/server.key"

  mkdir "${PWD}/../organizations/peerOrganizations/auditor.com/msp/tlscacerts"
  cp "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/auditor.com/msp/tlscacerts/ca.crt"

  mkdir "${PWD}/../organizations/peerOrganizations/auditor.com/tlsca"
  cp "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/auditor.com/tlsca/tlsca.auditor.com-cert.pem"

  mkdir "${PWD}/../organizations/peerOrganizations/auditor.com/ca"
  cp "${PWD}/../organizations/peerOrganizations/auditor.com/peers/peer0.auditor.com/msp/cacerts/"* "${PWD}/../organizations/peerOrganizations/auditor.com/ca/ca.auditor.com-cert.pem"

  infoln "Generating the user msp"
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-auditor -M "${PWD}/../organizations/peerOrganizations/auditor.com/users/User1@auditor.com/msp" --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/auditor.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/auditor.com/users/User1@auditor.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
	fabric-ca-client enroll -u https://auditoradmin:auditoradminpw@localhost:11054 --caname ca-auditor -M "${PWD}/../organizations/peerOrganizations/auditor.com/users/Admin@auditor.com/msp" --tls.certfiles "${PWD}/fabric-ca/auditor/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/auditor.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/auditor.com/users/Admin@auditor.com/msp/config.yaml"
}
