variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "prototyping-jxc1598"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = ""
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-east1"
}

variable "zone" {
  description = "The zone to host the cluster in"
  default     = "us-east1-c"
}


# See: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/issues/610
variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  default     = ""
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
  default     = ""
}

# variable "compute_engine_service_account" {
#   description = "Service account to associate to the nodes in the cluster"
#   default = "custom-gce-dealer@prototyping-jxc1598.iam.gserviceaccount.com"
# }