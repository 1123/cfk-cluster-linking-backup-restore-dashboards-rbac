kubectl create configmap -n confluent grafana-kafka-cluster --from-file kafka-cluster.json
kubectl label configmap grafana-kafka-cluster grafana_dashboard=1

kubectl create configmap -n confluent cluster-linking --from-file cluster-linking.json
kubectl label configmap cluster-linking grafana_dashboard=1
