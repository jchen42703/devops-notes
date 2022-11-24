locals {
  cluster_type = "deploy-service"
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# GKE
module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google"
  project_id = var.project_id
  name       = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  region     = var.region
  zones       = [var.zone]
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_range_pods          = var.ip_range_pods
  ip_range_services      = var.ip_range_services
  create_service_account = true
  # service_account        = var.compute_engine_service_account
  default_max_pods_per_node = 2
  initial_node_count        = 1
  #   http_load_balancing        = false
  # network_policy             = false
  # horizontal_pod_autoscaling = true
  # filestore_csi_driver       = false

  # node_pools = [
  #   {
  #     name                      = "default-node-pool"
  #     machine_type              = "e2-medium"
  #     node_locations            = "us-central1-b,us-central1-c"
  #     min_count                 = 1
  #     max_count                 = 100
  #     local_ssd_count           = 0
  #     spot                      = false
  #     disk_size_gb              = 100
  #     disk_type                 = "pd-standard"
  #     image_type                = "COS_CONTAINERD"
  #     enable_gcfs               = false
  #     enable_gvnic              = false
  #     auto_repair               = true
  #     auto_upgrade              = true
  #     service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
  #     preemptible               = false
  #     initial_node_count        = 80
  #   },
  # ]

  # node_pools_oauth_scopes = {
  #   all = [
  #     "https://www.googleapis.com/auth/logging.write",
  #     "https://www.googleapis.com/auth/monitoring",
  #   ]
  # }

  # node_pools_labels = {
  #   all = {}

  #   default-node-pool = {
  #     default-node-pool = true
  #   }
  # }

  # node_pools_metadata = {
  #   all = {}

  #   default-node-pool = {
  #     node-pool-metadata-custom-value = "my-node-pool"
  #   }
  # }

  # node_pools_taints = {
  #   all = []

  #   default-node-pool = [
  #     {
  #       key    = "default-node-pool"
  #       value  = true
  #       effect = "PREFER_NO_SCHEDULE"
  #     },
  #   ]
  # }

  # node_pools_tags = {
  #   all = []

  #   default-node-pool = [
  #     "default-node-pool",
  #   ]
  # }
}

resource "kubernetes_pod" "nginx-example" {
  metadata {
    name = "nginx-example"

    labels = {
      maintained_by = "terraform"
      app           = "nginx-example"
    }
  }

  spec {

    container {
      image = "nginx:1.23.2"
      name  = "nginx-example"
    }
  }

  depends_on = [module.gke]
}

resource "kubernetes_service" "nginx-example" {
  metadata {
    name = "terraform-example"
  }

  spec {
    selector = {
      app = kubernetes_pod.nginx-example.metadata[0].labels.app
    }

    session_affinity = "ClientIP"

    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [module.gke]
}