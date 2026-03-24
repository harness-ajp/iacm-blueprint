terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# No credentials here — KUBE_CONFIG_PATH env var is injected by IACM
# from the K8s connector attached to the workspace
provider "kubernetes" {}

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
