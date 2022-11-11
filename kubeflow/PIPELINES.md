# Kubeflow Pipelines

## Kubeflow Pipelines: The Basics and a Quick Tutorial

https://www.run.ai/guides/kubernetes-architecture/kubeflow-pipelines-the-basics-and-a-quick-tutorial

## What are Kubeflow Pipelines?

- help you build and deploy container-based machine learning (ML) workflows that are portable and scalable.
- Each pipeline represents an ML workflow, and includes the specifications of all inputs needed to run the pipeline, as well the outputs of all components.

## Common Kubeflow Use Cases

- Deploying models to production

  - I.e. model behind REST API
  - can get complex when you to update/rollback the model but there are multiple applications consuming that model output
  - Kubeflow lets you update your model in one space and ensures that all client applications quickly get the updates

- Shared Multi Tenant ML Environment

  - ML environments and resources often need to be shared (i.e. GPUs)
  - Kubernetes enables scheduling and managing containers, can help you isolate workflows and keep track of pending/running jobs for each collaborator

- Running Jupyter Notebooks on GPUs
  - Normally, using Jupyter Notebooks with GPUs causes security issues (unauthorized access b/c data is so distributed)
  - Kubeflow Pipelines, on the other hand, enable data scientists to build their workflow into a container and execute it in an environment authorized by the security team.

## Kubeflow Pipelines Architecture

- Use Python SDK to buld components and designate a pipeline
- DSL compiler converts Python to static config in yaml.
- Pipeline Service creates the pipeline run from a static configuration
- Kubernetes resources (the required custom resources definition/CRD) runs the pipeline upon a call to the Kubernetes API server by the pipeline service.
- Artifact Storage:
  - Artifact: stuff created by runs (metrics, views, and pipeline packages)
  - Kubeflow stores metadata in a MySQL database and artifacts an artifact store.
  - Can use metric for sorting/filtering
- Orchestration Controllers
  - i.e. Argo Workflow
  - Task driven
  - Prompt the containers required to finalize the pipeline
  - These containers operate in Kubernetes pods
- Persistence Agent & ML metadata
  - Pipelines use a Persistence Agent to monitor service-created Kubernetes resources
  - Help maintain their state in the ML Metadata Service
  - Records executed container sets, their inputs, and outputs
  - I/O can be data artifact URIs or container parameters
  - Pipeline Web Server
    - UI for Pipeline
