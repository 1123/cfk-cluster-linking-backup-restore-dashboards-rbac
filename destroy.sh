#!/bin/bash

NAMESPACE=confluent

kubectl config set-context --current --namespace=$NAMESPACE > /dev/null

kubectl delete -f strimzi-to-cp-link.yaml

kubectl delete -f demo/restproxy.yaml
kubectl delete -f demo/connect.yaml
kubectl delete -f demo/schemaregistry.yaml

kubectl delete secret oauth-jass 

kubectl delete secret ca-pair-sslcerts

kubectl delete secret mds-token

kubectl delete \
  -f security/oauth/keycloak/keycloak_deploy.yaml

helm repo add confluentinc https://packages.confluent.io/helm

helm upgrade \
  --install operator confluentinc/confluent-for-kubernetes 

kubectl delete namespace $NAMESPACE

