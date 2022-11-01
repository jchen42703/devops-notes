# Terraform Crash Course

https://blog.gruntwork.io/a-crash-course-on-terraform-5add0d9ef9b4

From: https://developer.hashicorp.com/terraform/cli/commands/fmt

To format:

```bash
terraform fmt -write=true
```

## Workflow

```bash
terraform init
terraform plan
terraform apply
```

## Nuanced Lessons

**Resources are region-scoped.**

- If you have ssh keys created in `us-east-1`, you cannot access them if you are running Terraform for `us-east-2`.

**AWS updates their Linux image very often.**

- AWS Linux -> AWS Linux 2
  - There is also AWS Linux 2022, but it's not available right now for general use.

**If you have to run terraform commands from scratch (i.e. no cached dependencies or lock files), then you need to import the objects you need or you'll get something like:**

```bash
Error: creating Security Group (terraform-example): InvalidGroup.Duplicate: The security group 'terraform-example' already exists for VPC 'vpc-04861370183d61988'
│       status code: 400, request id: f1f3821b-baf9-407a-a85d-e2e99e198357
│
│   with aws_security_group.instance,
│   on main.tf line 9, in resource "aws_security_group" "instance":
│    9: resource "aws_security_group" "instance" {
│
```

To fix this (according to [this](https://stackoverflow.com/questions/60228784/error-creating-security-group-invalidgroup-duplicate-when-defining-aws-security)), import the resource into Terraform so it knows about it:

```bash
terraform import aws_security_group.instance sg-XXXXXXXXXXX
```

A consequence is that if you run `terraform destroy`, it will also clean up that imported resource as well.

## Things to Review

- environment variables with terraform:
  - https://support.hashicorp.com/hc/en-us/articles/4547786359571-Reading-and-using-environment-variables-in-Terraform-runs
- startup script
  - https://fabianlee.org/2021/05/28/terraform-invoking-a-startup-script-for-an-ec2-aws_instance/
  - https://brad-simonin.medium.com/learning-how-to-execute-a-bash-script-from-terraform-for-aws-b7fe513b6406
  - https://stackoverflow.com/questions/63978548/how-to-run-scritps-after-create-ec2-using-terraform-during-apply
  -
