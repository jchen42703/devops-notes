# Deploy a GKE cluster with Terraform

https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke

Configuring `gcloud`:

- `gcloud init`
- `gcloud auth application-default login`

`git clone https://github.com/hashicorp/learn-terraform-provision-gke-cluster`

## Steps

1. Provision the GKE cluster with Terraform.

- This process should take approximately 10 minutes...

2. Need to configure kubectl for the gke cluster.

```bash
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)
```

3. Start the K8s dashboard

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

kubectl proxy
# Access dashboard at:
# http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

4. Authenticate to the K8s dashboard

```bash
# Creates a ClusterRoleBinding resource
kubectl apply -f https://raw.githubusercontent.com/hashicorp/learn-terraform-provision-gke-cluster/main/kubernetes-dashboard-admin.rbac.yaml

# Generates the auth token.
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')

# Now, just copy paste the token into the dashboard auth screen to sign in.
```

**Side Notes:**

- Provisions 2 nodes per zone, so the tutorial provisions 6 total nodes.

## Using GKE with Terraform

https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform

**Tips**

- Use the official GKE Terraform module (https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest)

## Resources

- [How to create a Google Kubernetes Engine Cluster in GCP with Terraform](https://www.youtube.com/watch?v=qf_fsOEj-OU)
- [How to Create GKE Cluster Using TERRAFORM? (Google Kubernetes Engine & Workload Identity)](https://www.youtube.com/watch?v=X_IK0GBbBTw)
- Self-Managed
  - https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-public-cloud/gce
