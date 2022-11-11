# A 10 Minute Introduction to Kubeflow: Basics, Architecture & Components

https://www.youtube.com/watch?v=G7zW1Wqym00

## Benefits of K8s for ML & Data Science

- **Portability:** Write once, reproduce and deploy everywhere
- **Microservices:** Workflows need to interact with multiple services
- **Scaling:** Scaling down quickly is just as important as scaling up

## Kubeflow

ML + K8s = Kubeflow

Complete toolkit for ML workflow

- data
- training
- tuning
- serving
- monitoring

## Architecture & Components

Is a collection of different services that are all built on top of Kubernetes

- Central Dashboard
- Notebook Servers
  - Lets you build in a Jupyter Notebook and move it to production
- Kubeflow Pipelines
  - Build and deploy, scalable ML workflows based on Docker containers.
- KFServing/kserve
  - Serve ML models, supports multiple frameworks
  - Encapsulates lots of complexity (auto-scaling, etc)
- Katib
  - AutoML in KubeFlow
  - Hyperparameter Tuning
- Training Operators
  - Train ML models with operators
    - i.e. Tensorflow training via the `tf-operator`
    - etc.

# Kubernetes in 5 Minutes

https://www.youtube.com/watch?v=PH-2FfFD2PU

Can enforce desired state management.

K8s Cluster Services takes a config and deploys some infrastructure. Kubelets (containers/workers) communicate with the K8s cluster services.

## Use Case

Feed deployment yaml to K8s Cluster Services

- Pod configuration
  - specify container image
  - Specify number of pods
- Specify other pods

Kubernetes vs Terraform vs. Docker Compose

- Kubernetes is like a more complex Docker Compose
  - more features, but also more to learn
- Terraform lets you spin up managed Kubernetes clusters on services, such as EKS, AKS, and GKE.

# What is Kubernetes | Kubernetes explained in 15 mins

https://www.youtube.com/watch?v=VnvRFRk_51k&t=274s

Container orchestration.

Helps you manage containerized applications in different environments (physical, vm, cloud, hybrid).

## Need

- Trend from Monolith to Microservices
- But...managing tons of containers is a massive pain.
- Here comes Kubernetes!

## Features?

- High availability (no downtime)
- Scalability (high performance)
- Disaster Recovery (backup and restore)

# Kubernetes clicked when I learned about Deployments and Services

https://ljvmiranda921.github.io/notebook/2020/01/18/kubernetes-deployments/

- Understanding Pods and Nodes are good conceptually, since they are a natural progression of what I know so far: Docker containers can be mapped into Pods, and the machines where these containers are run can be mapped into Nodes. **However in practice, this bottom-up approach didn’t help because there’s more to Kubernetes than Pods and Nodes.** If I want to deploy an application, there’s a lot of things I still need to think about.

- The simplest and oft-used Kubernetes use-case: “I want to have X in my cluster that is accessible via Y”
  - The deployment is X (what you want to do)
  - We can access X via Y (the Kubernetes service)

For example, "I want to have **Redis** in my cluster that is accessible **only within the cluster**":

```yaml
# "I want to have <X> Redis in my cluster that is accessible
# <Y> only within the cluster"
apiVersion: apps/v1
kind: Deployment
spec:
  # ...
  selector:
    matchLabels:
      app: redis
  template:
    spec:
      containers: # Make me a container...
        - name: redis # ...named `redis` based on...
          image: redis # ..this image
---
apiVersion: v1
kind: Service
spec:
  type: ClusterIP
  ports:
    - port: 6379
      targetPort: 6379
  selector:
    app: redis
```

The idea of "deployments" and "services" provide a direct mapping between "what I want to do" and "how to do it."

# Distill: Why do we need Flask, Celery, and Redis? (with McDonalds in Between)

https://ljvmiranda921.github.io/notebook/2019/11/08/flask-redis-celery-mcdo/

Celery provides the framework to write workers for running your services.

- allow workers to communicate with the database backend.

Can improve Lyne with a better queuing architecture.

# Kubernetes in Production | 8 Tips & Best Practices in 2022

https://www.containiq.com/post/kubernetes-in-production

# Other Resources

https://kodekloud.com/

https://github.com/kelseyhightower/kubernetes-the-hard-way

- K8s Costs
  - https://www.containiq.com/post/kubernetes-cost-monitoring
  - https://cast.ai/blog/kubernetes-cost-estimation-4-problems-and-how-to-solve-them/
