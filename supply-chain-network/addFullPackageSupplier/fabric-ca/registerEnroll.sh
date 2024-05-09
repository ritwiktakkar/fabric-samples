#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

function createFullPackageSupplier {
	infoln "Enrolling the CA admin"
	mkdir -p ../organizations/peerOrganizations/fullpackagesupplier.com/

	export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-fullpackagesupplier --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-fullpackagesupplier.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-fullpackagesupplier.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-fullpackagesupplier.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-fullpackagesupplier.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/msp/config.yaml"

	infoln "Registering peer0"
  set -x
	fabric-ca-client register --caname ca-fullpackagesupplier --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-fullpackagesupplier --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-fullpackagesupplier --id.name fullpackagesupplieradmin --id.secret fullpackagesupplieradminpw --id.type admin --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
	fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-fullpackagesupplier -M "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/msp" --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates, use --csr.hosts to specify Subject Alternative Names"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-fullpackagesupplier -M "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls" --enrollment.profile tls --csr.hosts peer0.fullpackagesupplier.com --csr.hosts localhost --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null


  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/ca.crt"
  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/signcerts/"* "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/server.crt"
  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/keystore/"* "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/server.key"

  mkdir "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/msp/tlscacerts"
  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/msp/tlscacerts/ca.crt"

  mkdir "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/tlsca"
  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/tls/tlscacerts/"* "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/tlsca/tlsca.fullpackagesupplier.com-cert.pem"

  mkdir "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/ca"
  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/peers/peer0.fullpackagesupplier.com/msp/cacerts/"* "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/ca/ca.fullpackagesupplier.com-cert.pem"

  infoln "Generating the user msp"
  set -x
	fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-fullpackagesupplier -M "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/users/User1@fullpackagesupplier.com/msp" --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/users/User1@fullpackagesupplier.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
	fabric-ca-client enroll -u https://fullpackagesupplieradmin:fullpackagesupplieradminpw@localhost:11054 --caname ca-fullpackagesupplier -M "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/users/Admin@fullpackagesupplier.com/msp" --tls.certfiles "${PWD}/fabric-ca/fullpackagesupplier/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/msp/config.yaml" "${PWD}/../organizations/peerOrganizations/fullpackagesupplier.com/users/Admin@fullpackagesupplier.com/msp/config.yaml"
}
