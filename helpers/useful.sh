#!/bin/bash

# Kill prior services running on the ports
for port in 9090 8080 9093 8501 5000 2746; do
  fuser -k $port/tcp
done

# Start port forwarding
kubectl port-forward -n prometheus svc/kube-prometheus-stack-prometheus 9090:9090 &
kubectl port-forward svc/argocd-server -n argocd 8080:80 &
kubectl port-forward svc/argowf-argo-workflows-server -n argowf 2746 &
kubectl -n prometheus port-forward svc/kube-prometheus-stack-alertmanager  9093 &
kubectl -n bigbertha port-forward svc/llmchatbot 8501 5000 &

# Wait for all port forwarding processes to finish before exiting
wait
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
SECRET=$(kubectl get sa argowf-argo-workflows-server -o=jsonpath='{.secrets[0].name}'  -n argowf) 
ARGO_TOKEN="Bearer $(kubectl get secret $SECRET -o=jsonpath='{.data.token}' -n argowf | base64 --decode)"