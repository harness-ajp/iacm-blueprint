variable "namespace_name" {
  type        = string
  description = "Name of the namespace to create"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "namespace_description" {
  type    = string
  default = ""
}
