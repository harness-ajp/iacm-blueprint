variable "k8s_host" {
  type      = string
  sensitive = true
}

variable "k8s_ca_cert" {
  type      = string
  sensitive = true
}

variable "k8s_token" {
  type      = string
  sensitive = true
}

variable "namespace_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "namespace_description" {
  type    = string
  default = ""
}
