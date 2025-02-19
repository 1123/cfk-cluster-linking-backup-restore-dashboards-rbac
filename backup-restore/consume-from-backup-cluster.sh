kubectl exec backup-kafka-0 -n confluent -- \
  kafka-console-consumer \
    --topic sampletopic \
    --bootstrap-server backup-kafka.confluent.svc.cluster.local:9071 \
    --consumer-property group.id=g1 \
    --consumer-property commit.interval.ms=10 \
    --max-messages 100 \
    --from-beginning
