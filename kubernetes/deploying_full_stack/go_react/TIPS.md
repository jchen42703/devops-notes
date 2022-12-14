# Tips Learned From This Tutorial

https://betterprogramming.pub/deploy-a-full-stack-go-and-react-app-on-kubernetes-4f31cdd9a48b

Basic deployments are similar to docker compose files.

- Deployments are objects maintaining the state of **identical pods**
- Have deployments communicate with each other through a `ClusterIP` service
  - **The simplest and oft-used Kubernetes use-case: “I want to have X in my cluster that is accessible via Y”**
    - The deployment is X (what you want to do)
    - We can access X via Y (the Kubernetes service)

**Minikube Pre-Reqs**

1. Install `minikube`
2. `minikube start`
3. `minikube addons enable ingress`: added ingress controller

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

## Issues While Following Tutorial

- Had to change the config version for `ingress-service.yaml` to `networking.k8s.io/v1`

- Postgres deployment fails: `CrashLoopBackOff`
  - Opening up `minikube dashboard` lets us see the reason for the failure:
    - `MinimumReplicasUnavailable`: Deployment does not have minimum availability.
    - https://devops.stackexchange.com/questions/3980/what-does-does-not-have-minimum-availability-in-k8s-mean
    - **Use `kubectl describe pod <pod-name>` to get more specific debug info**
  - Never ended up figuring out how to fix it :P

## Commands

`kubectl apply`

- `apply` manages applications through files defining Kubernetes resources. It creates and updates resources in a cluster through running kubectl apply.

`kubectl apply -f k8s`

- Actually deploys everything

`kubectl get all`

- Gets the statuses of all deployments

`minikube ip`

- Gets the minkube ip
- Navigate to this IP to see the deployment
