kubectl exec backup-kafka-0 -n confluent -- \
  kafka-topics \
    --describe \
    --topic $1 \
    --bootstrap-server backup-kafka.confluent.svc.cluster.local:9071 
