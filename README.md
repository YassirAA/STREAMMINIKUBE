# STREAMMINIKUBE
```bash
minikube stop
minikube start --driver=docker
eval $(minikube docker-env)
docker build -t nginx-video-streaming .
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

## URL
```bash
minikube service nginx-video-service --url
```
