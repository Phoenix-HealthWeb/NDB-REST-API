#!/bin/bash

# Input .env file
ENV_FILE="../ndb_rest_api/.env"

# Output file
OUTPUT_FILE=".env"

# Check if the .env file exists
if [[ ! -f "$ENV_FILE" ]]; then
    echo "Error: $ENV_FILE not found!"
    exit 1
fi

# Process the .env file and save to the output file
grep -E '^export ' "$ENV_FILE" | sed 's/^export //' >"$OUTPUT_FILE"

echo "Variables have been saved to $OUTPUT_FILE without 'export'."

if minikube status &>/dev/null; then
    echo "Minikube is already running."
else
    echo "Starting Minikube..."
    minikube start
fi

minikube addons enable metrics-server

if kubectl get secret postgres-secret &>/dev/null; then
    echo "Secret 'postgres-secret' already exists. Skipping creation."
else
    kubectl create secret generic postgres-secret --from-env-file=.env
    echo "Secret 'postgres-secret' created successfully."
fi

kubectl apply -f ndb-deployment.yml

kubectl apply -f ndb-rest-api-deployment.yml