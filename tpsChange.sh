#!/bin/bash

# Name of the ConfigMap
configmap_name="kvbenchmark-config"

# Key to update
key_to_update="TPS"

# New value
new_value="50000"

# Create a temporary ConfigMap YAML file
cat <<EOF > temp-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: $configmap_name
data:
  $key_to_update: "$new_value"
EOF

# Apply the updated ConfigMap using kubectl apply
kubectl apply -f temp-configmap.yaml

# Clean up the temporary file
rm temp-configmap.yaml

echo "ConfigMap $configmap_name updated with $key_to_update=$new_value"

sleep 2

kubectl rollout restart deployment voltkv 
