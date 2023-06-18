#!/bin/bash

set -e

kubeconfig="/root/.kube/config"

kubectl_apply() {
    local deployment_file="$1"

    kubectl apply -f "$deployment_file" --kubeconfig "$kubeconfig"
}

deployment_file="deployment.yml"
kubectl_apply "$deployment_file"

