kubectl exec source-kafka-0 -n confluent -- \
  kafka-producer-perf-test \
    --topic demotopic \
    --producer-props bootstrap.servers=localhost:9092 \
    --num-records 10000 \
    --throughput 1000 \
    --record-size 1000
