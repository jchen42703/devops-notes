# Helm

Used to manage packages in Kubernetes.

- TLDR; lets you group up K8s config files into packages and makes managing this packages (upgrading/downgrading) easy

## Concepts

- A Chart is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster. Think of it like the Kubernetes equivalent of a Homebrew formula, an Apt dpkg, or a Yum RPM file.
- A Repository is the place where charts can be collected and shared. It's like Perl's CPAN archive or the Fedora Package Database, but for Kubernetes packages.
- A Release is an instance of a chart running in a Kubernetes cluster. One chart can often be installed many times into the same cluster. And each time it is installed, a new release is created. Consider a MySQL chart. If you want two databases running in your cluster, you can install that chart twice. Each one will have its own release, which will in turn have its own release name.

**Helm installs `charts` into Kubernetes, creating a new `release` for each installation. And to find new charts, you can search Helm chart `repositories`.**

## Resources

- **Concept Overview:** https://helm.sh/docs/intro/using_helm/
- **Common Commands:** https://helm.sh/docs/intro/quickstart/
- Tutorials
  - [Full Tutorial — Deploying Helm Charts in Kubernetes with Terraform](https://anaisurl.com/helm-chart-terraform-deployment/)
  - [How I use Terraform and Helm to deploy the Kubernetes Dashboard](https://opensource.com/article/21/8/terraform-deploy-helm)
- Deploy Full Stack Application with Kubernetes and Helm
  - [Create And Deploy A MERN Stack As A Helm Chart](https://eskala.io/tutorial/create-and-deploy-a-mern-stack-as-a-helm-chart/)
  - [OUR K8S HELM CHART FOR FULL STACK NODE.JS APPS](https://www.froehlichundfrei.de/blog/2019-05-17-our-k8s-helm-chart-for-full-stack-nodejs-apps/)
  - [Create And Deploy A MEAN Stack As A Helm Chart](https://eskala.io/tutorial/create-and-deploy-a-mean-stack-as-a-helm-chart/)

## Video Tutorials

- [Deploying a Kubernetes app using Helm](https://www.youtube.com/watch?v=84Wvr54Rn2U)
