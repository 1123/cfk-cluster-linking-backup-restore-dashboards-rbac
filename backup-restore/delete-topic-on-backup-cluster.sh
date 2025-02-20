kubectl exec backup-kafka-0 -n confluent -- \
  kafka-topics \
    --delete \
    --topic $1 \
    --bootstrap-server backup-kafka.confluent.svc.cluster.local:9071 
