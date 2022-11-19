# Kubernetes

# Kubernetes at Reddit: Tales from Production - Greg Taylor, Reddit, Inc

## Enforce Protected Policies with OPA

https://www.youtube.com/watch?v=WTbIBqNcjoQ

https://www.openpolicyagent.org/

- Guard rails for security

## Managing Helm Charts

- Create a baseline resource generator

# Kubernetes Failure Stories, or: How to Crash Your Cluster - Henning Jacobs

https://www.youtube.com/watch?v=LpFApeaGv7A

## Incident 1

- kubelet was delayed in updating Pod statuses for multiple minutes
  - Rapid creation and deletion of Pods caused kubelet to fall behind
- **Cause:** Default K8s config has low rate limit for calls to the API server (`kube-api-qps`)

## Incident 3

- Kubernetes ndots:5 problem

  - ndots: This is the most interesting value and is the highlight of this post. ndots represents the threshold value of the number of dots in a query name to consider it as a "fully qualified" domain name.

## Incident 4

- RFTM
- Have a disaster recovery plan
- Backup etcd to S3
  - **etcd:** consistent and highly available key value store used to backup all cluster data in K8s
- Monitor snapshots

## Indicent 5: Connection Issues

K8s worker and master nodes sometimes fail to connect to etcd causing timeouts in API server and disconnects in the pod network.

- **Stop the bleeding** by having cronjobs to restart etcd
- Confirmation from AWS
  - T2 had networking problems
  - Switched away from T2

Kubernetes components are not necessarily "cloud native."

## Indicent 6: Need to Test e2e Upgrade Pass

Testing upgrades with E2E Tests

Instead of just:

1. Create cluster
2. Run e2e tests
3. Delete cluster

Need to consider: does it upgrade well?

1. Create cluster
2. **Upgrade cluster**
3. Run e2e tests
4. Delete cluster

## Indicent 7: Kernel OOM Killer

Kubelet Memory Leak on 1.12.5

## Incident 8: Error During Pod Creation

Could not provision credentials --> all new K8s deployments fail

**What happened?**

- Scaled down IAM provider to reduce **slack** while the number of deployments increased
- process could not process credentials fast enough
- CPU/memory requests "block" resources on nodes
  - The difference between the actual usage and requests is the **slack**
  - Want to reduce **slack** to save costs
- **Disable CPU throttling**
  - Set memory limit == request
  - Don't set CPU limit

## Other

- Docker daemon freezing so use latest docker version
- high DNS latency
- client-go still has issues with timeouts
  - can use etcd-proxy to fix timeouts
    - kinda hacky but it works
- 502s during cluster updates and race conditions during network setup

## Managed K8s?

Not really.

- AWS EKS uptime SLA is only for the API server.

- Still has lots you need to learn to scale to production
- DNS lookup scaling not clear
