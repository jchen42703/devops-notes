# Tips Learned From This Tutorial

https://betterprogramming.pub/deploy-a-full-stack-go-and-react-app-on-kubernetes-4f31cdd9a48b

Basic deployments are similar to docker compose files.

- Deployments are objects maintaining the state of **identical pods**
- Have deployments communicate with each other through a `ClusterIP` service
  - **The simplest and oft-used Kubernetes use-case: “I want to have X in my cluster that is accessible via Y”**
    - The deployment is X (what you want to do)
    - We can access X via Y (the Kubernetes service)

**Workflow**

1. Create docker images.
2. Create K8s deployment configs.
   1. Backend, Frontend, DB
3. Create K8s service configs.
   1. One for each deployment config (1-1)
4. Create ingress service config.
   1. Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster.
   2. The IngressController service is the actual reverse proxy which receives the traffic.
   3. In this tutorial, we use the `NGINX IngressController`

## Misc

`kubectl apply`

- `apply` manages applications through files defining Kubernetes resources. It creates and updates resources in a cluster through running kubectl apply.

Had to change the config version for `ingress-service.yaml` to `networking.k8s.io/v1`

## Commands

`kubectl apply -f k8s`

- Actually deploys everything

`kubectl get all`

- Gets the statuses of all deployments

`minikube ip`

- Gets the minkube ip
- Navigate to this IP to see the deployment
