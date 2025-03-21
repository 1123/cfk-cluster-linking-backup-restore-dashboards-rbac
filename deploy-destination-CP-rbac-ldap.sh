set -e -u

export NAMESPACE=confluent
export TUTORIAL_HOME=demo

mkdir assets/certs/generated || echo could not create directory $_
openssl genrsa -out assets/certs/generated/ca-key.pem 2048
openssl req -x509  -new -nodes \
  -key assets/certs/generated/ca-key.pem \
  -days 3650 \
  -out assets/certs/generated/ca.pem \
  -subj "/C=US/ST=CA/L=MVT/O=TestOrg/OU=Cloud/CN=TestCA"

helm repo add confluentinc https://packages.confluent.io/helm
kubectl create namespace $NAMESPACE || echo "Could not create namespace $NAMESPACE"

kubectl config set-context --current --namespace=$NAMESPACE

helm upgrade --install operator confluentinc/confluent-for-kubernetes --namespace $NAMESPACE

helm upgrade --install \
  -f assets/openldap/ldaps-rbac.yaml test-ldap assets/openldap --namespace $NAMESPACE

kubectl create secret generic credential \
  --from-file=plain-users.json=$TUTORIAL_HOME/creds-kafka-sasl-users.json \
  --from-file=digest-users.json=$TUTORIAL_HOME/creds-zookeeper-sasl-digest-users.json \
  --from-file=digest.txt=$TUTORIAL_HOME/creds-kafka-zookeeper-credentials.txt \
  --from-file=plain.txt=$TUTORIAL_HOME/creds-client-kafka-sasl-user.txt \
  --from-file=basic.txt=$TUTORIAL_HOME/creds-control-center-users.txt \
  --from-file=ldap.txt=$TUTORIAL_HOME/ldap.txt 

kubectl create secret generic mds-token \
  --from-file=mdsPublicKey.pem=assets/certs/mds-publickey.txt \
  --from-file=mdsTokenKeyPair.pem=assets/certs/mds-tokenkeypair.txt 

# Kafka RBAC credential
kubectl create secret generic mds-client \
  --from-file=bearer.txt=$TUTORIAL_HOME/bearer.txt 
  
# Control Center RBAC credential
kubectl create secret generic c3-mds-client \
  --from-file=bearer.txt=$TUTORIAL_HOME/c3-mds-client.txt 

# Connect RBAC credential
kubectl create secret generic connect-mds-client \
  --from-file=bearer.txt=$TUTORIAL_HOME/connect-mds-client.txt 

# Schema Registry RBAC credential
kubectl create secret generic sr-mds-client \
  --from-file=bearer.txt=$TUTORIAL_HOME/sr-mds-client.txt 

# ksqlDB RBAC credential
kubectl create secret generic ksqldb-mds-client \
  --from-file=bearer.txt=$TUTORIAL_HOME/ksqldb-mds-client.txt 

# Kafka Rest Proxy RBAC credential
kubectl create secret generic krp-mds-client \
  --from-file=bearer.txt=$TUTORIAL_HOME/krp-mds-client.txt 

# Kafka REST credential
kubectl create secret generic rest-credential \
  --from-file=bearer.txt=$TUTORIAL_HOME/bearer.txt \
  --from-file=basic.txt=$TUTORIAL_HOME/bearer.txt 

kubectl create secret generic password-encoder-secret \
  --from-file=password-encoder.txt=$TUTORIAL_HOME/password-encoder-secret.txt

kubectl create secret tls ca-pair-sslcerts \
  --cert=assets/certs/generated/ca.pem \
  --key=assets/certs/generated/ca-key.pem

kubectl apply -f $TUTORIAL_HOME/confluent-platform-production-autogeneratedcerts.yaml 

kubectl apply -f $TUTORIAL_HOME/controlcenter-testadmin-rolebindings.yaml 

kubectl apply -f $TUTORIAL_HOME/kafka-rest-class-default.yaml
