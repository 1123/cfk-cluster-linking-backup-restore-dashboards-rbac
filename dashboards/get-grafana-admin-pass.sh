kubectl --namespace confluent get secrets prom-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo
