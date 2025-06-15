## Simple Rest API

This is a simple rest api for books. 

### How to Run Project

`go build`

`go run .` 

`http://localhost:8182/books`


or

`docker build -t example-book-app .` 

`docker run -p 9898:8080 -t example-book-app`

`http://localhost:9898/books`


### 1.1. Create an ECR Repository

- ```aws ecr create-repository --region eu-central-1 --repository-name example-book-app```

### 1.2. Authenticate Docker with ECR

- ```aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.eu-central-1.amazonaws.com```

### 1.3. Tag Your Local Image for ECR

- ```docker tag example-book-app:latest <account-id>.dkr.ecr.eu-central-1.amazonaws.com/example-book-app:latest```

### 1.4. Push the Image to ECR

- ```docker push <account-id>.dkr.ecr.eu-central-1.amazonaws.com/example-book-app:latest```

### 1.5. Create a simple K8S cluster on EKS
```
eksctl create cluster \
  --name one-node-cluster \
  --version 1.31 \
  --region eu-central-1 \
  --nodegroup-name one-node-group \
  --node-type t3.medium \
  --nodes 1 \
  --nodes-min 1 \
  --nodes-max 1 \
  --managed
```

### 1.6. Apply Kubernetes Manifests

- Change ```<account-id>``` in the deployment.yaml file:
  - image: ```<account-id>.dkr.ecr.eu-central-1.amazonaws.com/example-book-app:latest```


```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
### 1.7. Check Deployment & Access

```
kubectl get pods
kubectl get svc example-book-service
```

### 1.8. Access the App in Browser or cURL
- just use the EXTERNAL-IP or DNS name in your browser or terminal:
  - ```curl http://EXTERNAL-IP.elb.eu-central-1.amazonaws.com/books```
  - or
  - open ```http://EXTERNAL-IP.elb.eu-central-1.amazonaws.com/books```


## Delete resources

- Delete ECR Repository

```
aws ecr delete-repository \
  --repository-name example-book-app \
  --region eu-central-1 \
  --force
```

- Delete EKS Cluster 

```
eksctl delete cluster \
  --name one-node-cluster \
  --region eu-central-1
```




     





