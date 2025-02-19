# Make sure you have forwarded the quickstart-es-http service to localhost:9200
set -u -e

PASSWORD=$(kubectl -n confluent get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')

curl -u "elastic:$PASSWORD" -k -X POST "https://localhost:9200/_security/role/es_sink_connector_role?pretty" \
  -H 'Content-Type: application/json' -d'
{
"indices": [
   {
      "names": [ "-" ],
      "privileges": ["create_index", "read", "write", "view_index_metadata"]
   }
]
}'
curl -u "elastic:$PASSWORD" -k -X POST "https://localhost:9200/_security/user/es_sink_connector_user?pretty" \
  -H 'Content-Type: application/json' -d'
{
"password" : "seCret-secUre-PaSsW0rD",
"roles" : [ "es_sink_connector_role" ]
}'

