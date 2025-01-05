kubectl delete all --all
kubectl delete ingress --all
# Comment out the following line if you want to keep the persistent volumes
kubectl delete pvc --all && kubectl delete pv --all
