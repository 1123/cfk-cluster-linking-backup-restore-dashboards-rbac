kubectl cp destination.properties kafka-0:/tmp/destination.properties -n confluent
kubectl exec kafka-0 -n confluent -- \
  kafka-console-consumer \
    --topic sampletopic \
    --timeout-ms 10000 \
    --bootstrap-server kafka.confluent.svc.cluster.local:9071 \
    --consumer.config /tmp/destination.properties \
    --from-beginning
