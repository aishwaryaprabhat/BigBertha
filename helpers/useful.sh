kubectl port-forward -n prometheus svc/kube-prometheus-stack-prometheus 9090:9090 &
kubectl port-forward svc/argocd-server -n argocd 8080:80 &
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo