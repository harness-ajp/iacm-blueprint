# Provision all VLANs as bridge domains
resource "nxos_bridge_domain" "vlans" {
  for_each     = var.vlans
  fabric_encap = "vlan-${each.value.id}"
  name         = each.value.name
}

# Enable the SVI feature on NX-OS (required before creating SVIs)
resource "nxos_feature_interface_vlan" "enabled" {
  admin_state = "enabled"
}

# Create the IPv4 routing instance (dom-default) via raw DME object
resource "nxos_rest" "ipv4_inst" {
  dn         = "sys/ipv4/inst"
  class_name = "ipv4Inst"
  content = {
    adminSt = "enabled"
  }
}

# Create the default VRF domain under the IPv4 instance
resource "nxos_rest" "ipv4_dom_default" {
  dn         = "sys/ipv4/inst/dom-default"
  class_name = "ipv4Dom"
  content = {
    name = "default"
  }

  depends_on = [nxos_rest.ipv4_inst]
}

# Create an SVI for each VLAN
resource "nxos_svi_interface" "svis" {
  for_each     = var.vlans
  interface_id = "vlan${each.value.id}"
  admin_state  = "up"
  description  = each.value.description

  depends_on = [
    nxos_bridge_domain.vlans,
    nxos_feature_interface_vlan.enabled
  ]
}

# Enable IPv4 on each SVI
resource "nxos_ipv4_interface" "svi_ipv4" {
  for_each     = var.vlans
  interface_id = "vlan${each.value.id}"
  vrf          = "default"

  depends_on = [
    nxos_svi_interface.svis,
    nxos_rest.ipv4_dom_default
  ]
}

# Assign IP address to each SVI
resource "nxos_ipv4_interface_address" "svi_ips" {
  for_each     = var.vlans
  interface_id = "vlan${each.value.id}"
  vrf          = "default"
  address      = each.value.svi_ip

  depends_on = [nxos_ipv4_interface.svi_ipv4]
}
