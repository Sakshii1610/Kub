#!/bin/bash

# Set the namespace and pod name
NAMESPACE="your-namespace"
POD_NAME="your-pod-name"

# Define the YAML manifest for your pod
cat <<EOF | kubectl apply -n "$NAMESPACE" -f -
apiVersion: v1
kind: Pod
metadata:
  name: "$POD_NAME"
spec:
  containers:
  - name: your-container-name
    image: your-container-image:tag
    ports:
    - containerPort: 80
EOF

# Check if the pod is running
while true; do
  STATUS=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
  if [ "$STATUS" == "Running" ]; then
    break
  fi
  sleep 5
done

echo "Pod $POD_NAME is now running in namespace $NAMESPACE."
