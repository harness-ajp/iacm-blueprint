provider "nxos" {
  username = var.nxos_username
  password = var.nxos_password
  url      = var.nxos_host
  insecure = true
}
