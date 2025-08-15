# main.tf (OpenTofu uses .tf files too)
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_compute_instance" "vm_instance_1" {
  name         = "opentofu-vm-1"
  machine_type = "e1-micro"
  zone         = var.zone
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  
  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_instance" "vm_instance_2" {
  name         = "opentofu-vm-2"
  machine_type = "e1-micro"
  zone         = var.zone
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  
  network_interface {
    network = "default"
    access_config {}
  }
}
