# Deploy Server on GCE with Terraform

https://cloud.google.com/docs/terraform/get-started-with-terraform

Make sure you already have your environment configured and permissions enabled before starting this portion.

- TLDR; go through the [gce terraform getting started tutorial](../gce/README.md)

1. Create the VPC and subnet for the VM instance
2. Create instance
3. Add a custom SSH firewall rule
   1. Similar to AWS security groups
4. SSH into the instance and create the `flask` server.
   1. Don't really need to worry too much about this, but _shrug_
   2. SSH through console instead of with `ssh`
5. Need to add a custom firewall rule to open port 5000 on the VM for the API
   1. For an nginx deployment, open port 80!
   2. Pretty similar to the AWS deployment
6. Now you can go to the instance IP address with port 5000 and boom, you'll see the API response!
