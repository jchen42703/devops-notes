# Using Terraform to Launch a Compute Engine Instance in GCP

## Official Docs

https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started

1. Authenticate with GCP:

   ```bash
   gcloud auth application-default login
   ```

   Or just initialize it with:

   ```bash
   gcloud init
   ```

2. Create the service account through console (IAM >> Service Accounts).

   ```bash
   # Or do it with the command from the tutorial
   gcloud iam service-accounts create custom-gce-dealer \
   --display-name "Custom GCE Dealer"
   ```

   You can skip this step if you already have a service account.

3. Get the key json of that service account:

   ```bash
   gcloud iam service-accounts keys create ./compute-instance.json --iam-account <SERVICE_ACCOUNT_EMAIL>
   ```

   - The SERVICE_ACCOUNT_EMAIL can be found through the GCP Console: IAM & Admin >> Service Accounts
   - Make sure that the compute-instance.json is ignored by your `.gitignore`, so you don't commit it.

4. Run terraform!

```bash
terraform init
terraform plan
terraform apply
```

5. To cleanup, run: `terraform destroy`

## Key Concepts Unique to GCP

- `project` contains resources
- Need to specify both a `region` and a `zone` for each resource
- GCP uses the resource's `name` and `self_link` to identify it
  - Must refer to a resource by its `self_link`
- Must create a service account and export that service account's key for Terraform to use.

## Tips

When linking resources in Terraform, use the `self_link` of a resource:

```
{{API base url}}/projects/{{your project}}/{{location type}}/{{location}}/{{resource type}}/{{name}}
```

- that `self_link` is a unique reference to that resource
