# NDB-REST-API

1. Create your `.env` file
2. Run the `run.sh` file for local development

## Deploy through K8S (Minikube)
Add `127.0.0.1 ndb-api.com` to the /etc/hosts file.

Run `cd ./k8s && ./deploy.sh`

Run `kubectl get ingress` (CAN TAKE 1-2 MINUTES) until the IP address is assigned to nginx:

| NAME           | CLASS   | HOSTS         | ADDRESS        | PORTS | AGE    |
|----------------|---------|---------------|----------------|-------|--------|
| nginx-ingress  | nginx   | ndb-api.com   | 192.168.49.2   | 80    | 3m28s  |

Run `sudo minikube tunnel`

Open your browser on `http://ndb-api.com`
