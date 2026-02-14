# Remove the old TEST-VLAN port we created earlier
# (replace with the new cruise ship ports)
resource "nxos_physical_interface" "access_ports" {
  for_each     = var.access_ports
  interface_id = each.value.interface_id
  layer        = "Layer2"
  mode         = "access"
  access_vlan  = "vlan-${var.vlans[each.value.vlan_key].id}"
  admin_state  = "up"
  description  = each.value.description

  depends_on = [nxos_bridge_domain.vlans]
}
