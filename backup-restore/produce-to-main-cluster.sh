kubectl cp destination.properties kafka-0:/tmp/destination.properties -n confluent
kubectl exec kafka-0 -n confluent -- \
  kafka-producer-perf-test \
    --topic sampletopic \
    --producer-props bootstrap.servers=kafka.confluent.svc.cluster.local:9071 \
    --producer.config /tmp/destination.properties \
    --num-records 10 \
    --throughput 10 \
    --record-size 10000
