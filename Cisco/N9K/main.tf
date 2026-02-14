data "nxos_system" "nx" {}

output "switch_name" {
  value = data.nxos_system.nx.name
}

output "provisioned_vlans" {
  value = {
    for k, v in var.vlans : k => {
      vlan_id = v.id
      name    = v.name
      svi_ip  = v.svi_ip
    }
  }
}
