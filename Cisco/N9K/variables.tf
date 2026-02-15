variable "nxos_host" {
  description = "NX-OS device URL"
  type        = string
}

variable "nxos_username" {
  default = "<+secrets.getValue(\"cisco-devnet-username#nxos_username\")>"
  type    = string
}

variable "nxos_password" {
  default = "<+secrets.getValue(\"cisco-devnet-password#nxos_password\")>"
  type    = string
  sensitive = true
}

variable "vlans" {
  description = "Map of VLANs to provision"
  type = map(object({
    id          = number
    name        = string
    description = string
    svi_ip      = string
  }))
}

variable "access_ports" {
  description = "Map of access ports to provision"
  type = map(object({
    interface_id = string
    vlan_key     = string
    description  = string
  }))
}
