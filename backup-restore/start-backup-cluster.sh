kubectl annotate kraftcontroller backup-kraft platform.confluent.io/block-reconcile=false -n confluent --overwrite
kubectl annotate kafka backup-kafka platform.confluent.io/block-reconcile=false -n confluent --overwrite
