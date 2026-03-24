terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  host                   = var.k8s_host
  cluster_ca_certificate = base64decode(var.k8s_ca_cert)
  token                  = var.k8s_token
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace_name
    labels = {
      managed-by  = "opentofu"
      environment = var.environment
    }
    annotations = {
      "description" = var.namespace_description
    }
  }
}
