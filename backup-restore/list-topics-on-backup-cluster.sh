kubectl exec backup-kafka-0 -n confluent -- \
  kafka-topics \
    --list \
    --bootstrap-server backup-kafka.confluent.svc.cluster.local:9071 
