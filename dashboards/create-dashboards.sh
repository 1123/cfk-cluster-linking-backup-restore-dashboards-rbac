kubectl create configmap -n confluent grafana-kafka-cluster --from-file kafka-cluster.json
kubectl label configmap grafana-kafka-cluster grafana_dashboard=1
