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

## Adding HTTPs and DNS

https://medium.com/bluekiri/deploy-a-nginx-ingress-and-a-certitificate-manager-controller-on-gke-using-helm-3-8e2802b979ec
(Tutorial is out of date)

- https://cert-manager.io/docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl/

```yaml
# THIS VERSION IS OUT OF DATE, see the version I have in /k8s
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: ingress-resource
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
    # HOST HERE
    - host: poc-helm3.bluekiri.tech
      http:
        paths:
          - path: /helloworld
            backend:
              serviceName: hello-app
              servicePort: 8080
```

Create a namespace for the cert manager:

```bash
kubectl create namespace cert-manager
```

Then install the jetstack cert manager custom resource definition:

https://cert-manager.io/docs/installation/helm/

```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.10.1 \
  # --set installCRDs=true
```

Check that its running with:

```bash
kubectl get pods --namespace cert-manager
```

Add the issuer service:

**Start with staging PLEASE and make sure that the `ingress` matches the name of your ingress service.**

```yaml
# issuer-staging.yaml
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: jxc1598@case.edu # ❗ Replace this with your email address
    privateKeySecretRef:
      name: letsencrypt-staging
    solvers:
      - http01:
          ingress:
            name: web-ingress
```

Apply the issuer.

Create the intermediate `secret.yaml` as a placeholder and `kubectl apply` it.

> > This is a work around for a chicken-and-egg problem, where the ingress-gce controller won't update its forwarding rules unless it can first find the Secret that will eventually contain the SSL certificate. But Let's Encrypt won't sign the SSL certificate until it can get the special .../.well-known/acme-challenge/... URL which cert-manager adds to the Ingress and which must then be translated into Google Cloud forwarding rules, by the ingress-gce controller.

After a couple of minutes, you should be able to curl it:

```bash
# need --insecure because it's going to be a staging cert
curl -v --insecure https://easiermtl.com
```

Then, when you verify that the staging workflow works, do the production version:

```yaml
# issuer-prod.yaml
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-production
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: jxc1598@case.edu # ❗ Replace this with your email address
    privateKeySecretRef:
      name: letsencrypt-production
    solvers:
      - http01:
          ingress:
            name: web-ingress
```

Run `kubectl apply -f ./k8s/issuer-prod.yaml` to apply it.

Debug with `kubectl describe issuers.cert-manager.io letsencrypt-production`

## Cleanup

See the docs
