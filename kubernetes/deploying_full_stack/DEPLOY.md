# Deploying a Full Stack Application with Kubernetes

https://www.swtestacademy.com/deploy-full-stack-application-in-kubernetes/

- we need to have a database inside the Kubernetes pod that already has the table created.
  - build our own docker image that the table created and use that image in our Kubernetes file.
    - See tutorial for specific config
- Then, specify the database docker image with a K8s pod file

## Configuration Files Best Practices

https://stackoverflow.com/questions/48328415/kubernetes-questions-configuration-files

https://www.cloudytuts.com/guides/gitops-should-configs-have-own-repository/

https://stackoverflow.com/questions/47168381/best-practices-for-storing-kubernetes-configuration-in-source-control

TLDR; store deployment configs in a separate repository to prevent config updates from being held up by branches and other changes on that branch.

## Terraform vs. Helm

Terraform can be used to manage infrastructure and all the attached resources, while Helm's primary purpose is to manage applications and application states from within a Kubernetes cluster.
