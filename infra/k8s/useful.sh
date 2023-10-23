#!/bin/bash

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
kubectl -n argowf exec -it $(kubectl get pods -n argowf | grep argo-workflows-server | awk '{print $1}') -- argo auth token

# Kill prior services running on the ports
for port in 9090 8080 9093 8501 5000 2746; do
  fuser -k $port/tcp
done

# Start port forwarding
kubectl -n prometheus port-forward svc/kube-prometheus-stack-prometheus 9090:9090 &
kubectl -n argocd port-forward svc/argocd-server 8080:80 &
kubectl -n argowf port-forward svc/argowf-argo-workflows-server 2746 &
kubectl -n prometheus port-forward svc/kube-prometheus-stack-alertmanager  9093 &
kubectl -n bigbertha port-forward svc/llmchatbot 8501 5000 &
kubectl -n milvus port-forward svc/milvus-minio 9001 &
kubectl -n milvus port-forward svc/milvus-attu 8081:80 &
