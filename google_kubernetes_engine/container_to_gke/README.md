# Google Kubernetes Engine: Create GKE Cluster and Deploy Sample Website!!

https://www.youtube.com/watch?v=vIKy3pDz3jM

## From Documentation

https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app

Connecting to GKE cluster:

```bash
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
# Get the cluster connect command from GKE
# This connects kubectl to the GKE cluster`
gcloud container clusters get-credentials test-cluster-clone-1 --zone us-south1-a --project prototyping-jxc1598
```

Then, make your k8s configs.

Deploy with:

```bash
kubectl apply -f k8s
```

Next, you want to see if your deployment worked with:

https://stackoverflow.com/questions/49845021/getting-an-kubernetes-ingress-endpoint-ip-address

```bash
kubectl get nodes -o wide

kubectl get services
```

**Note:** Needed to add proper support for the nginx ingress service:

- https://cloud.google.com/community/tutorials/nginx-ingress-gke
- Uses helm

The main commands are:

```bash
# install the nginx ingress controller and uses the ingress config
helm install nginx-ingress ingress-nginx/ingress-nginx

# Verify that the deployment and service are up
kubectl get deployment nginx-ingress-ingress-nginx-controller
kubectl get service nginx-ingress-ingress-nginx-controller

# Get the nginx ingress IP with
export NGINX_INGRESS_IP=$(kubectl get service nginx-ingress-ingress-nginx-controller -ojson | jq -r '.status.loadBalancer.ingress[].ip')

echo $NGINX_INGRESS_IP
```

Or you can just do:

```bash
kubectl get ingress ingress-resource
```

- The displayed IP will be the same as the result of `echo $NGINX_INGRESS_IP`
- note: `ingress-resource` is just the name of the ingress service ([./k8s/ingress-service.yaml](./k8s/ingress-service.yaml))
