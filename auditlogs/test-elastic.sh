# Make sure you have forwarded the quickstart-es-http service to localhost:9200
PASSWORD=$(kubectl -n confluent get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
curl -u "elastic:$PASSWORD" -k "https://localhost:9200"


