# Terraform/GKE with the Official GKE Terraform Module

https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/master/examples

## Workflows

https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/tree/v24.0.0/examples/deploy_service

1. Provision a GKE cluster with Terraform.
2. Then, deploy a service to the created cluster using the Kubernetes provider.

## Provisioning a GKE Cluster

Need to consider these components:

- VPC
- Subnet
- GKE Cluster & Node Pool
