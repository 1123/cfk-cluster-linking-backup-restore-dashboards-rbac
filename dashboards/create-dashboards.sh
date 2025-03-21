for dashboard in cluster-linking.json kafka-connect-cluster.json kafka-quotas.json schema-registry-cluster.json confluent-platform.json kafka-consumer.json kafka-topics.json kafka-cluster.json kafka-producer.json; do
  basename=$(basename $dashboard .json) 
  echo kubectl create configmap -n confluent $basename --from-file $dashboard
  echo kubectl label configmap $basename grafana_dashboard=1
done

