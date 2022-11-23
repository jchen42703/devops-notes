provider "google" {
  #   credentials = file("./compute-instance.json")
  project = var.project_name
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "vm_instance" {
  name         = var.name
  machine_type = var.instance_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # Use the self_link of the resource!
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}