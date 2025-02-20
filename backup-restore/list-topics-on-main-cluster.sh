kubectl cp destination.properties kafka-0:/tmp/destination.properties -n confluent
kubectl exec kafka-0 -n confluent -- \
  kafka-topics \
    --list \
    --bootstrap-server kafka.confluent.svc.cluster.local:9071 \
    --command-config /tmp/destination.properties 
