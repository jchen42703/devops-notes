variable "project_name" {
  description = "The GCP project name that gcloud is configured with (with gcloud init)"
  type        = string
  default     = "prototyping-jxc1598"
}

variable "name" {
  description = "Name of the VM instance"
  type        = string
  default     = "gce-terraform"
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "f1-micro"
}

variable "region" {
  description = "GCE region to use"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCE zone to use"
  type        = string
  default     = "us-central1-c"
}

variable "image" {
    description = "Image to initialize the VM with"
  type        = string
  default     = "debian-cloud/debian-11"
}