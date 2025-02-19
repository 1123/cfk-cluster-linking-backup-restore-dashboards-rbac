kubectl annotate kafka backup-kafka \
  platform.confluent.io/block-reconcile=true \
  --overwrite \
  -n confluent
kubectl annotate kraftcontroller backup-kraft \
  platform.confluent.io/block-reconcile=true \
  --overwrite \
  -n confluent
kubectl scale statefulset backup-kafka \
  --replicas=0 -n confluent
kubectl scale statefulset backup-kraft \
  --replicas=0 -n confluent
