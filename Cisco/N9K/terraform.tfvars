nxos_host     = "https://sbx-nxos-mgmt.cisco.com"
nxos_username = ""
nxos_password = ""

vlans = {
  mgmt = {
    id          = 10
    name        = "MGMT-OOB"
    description = "Out-of-band management"
    svi_ip      = "10.0.10.1/24"
  }
  crew = {
    id          = 20
    name        = "CREW-OPS"
    description = "Crew and operations"
    svi_ip      = "10.0.20.1/24"
  }
  passenger = {
    id          = 30
    name        = "PASSENGER-WIFI"
    description = "Passenger guest WiFi"
    svi_ip      = "10.0.30.1/24"
  }
  entertainment = {
    id          = 40
    name        = "ENTERTAINMENT"
    description = "IPTV and entertainment systems"
    svi_ip      = "10.0.40.1/24"
  }
  pos = {
    id          = 50
    name        = "POS-RETAIL"
    description = "Point of sale and retail"
    svi_ip      = "10.0.50.1/24"
  }
  bridge = {
    id          = 60
    name        = "BRIDGE-NAV"
    description = "Bridge and navigation systems"
    svi_ip      = "10.0.60.1/24"
  }
  engine = {
    id          = 70
    name        = "ENGINE-OT"
    description = "Engine room and OT systems"
    svi_ip      = "10.0.70.1/24"
  }
  medical = {
    id          = 80
    name        = "MEDICAL"
    description = "Medical systems"
    svi_ip      = "10.0.80.1/24"
  }
}

access_ports = {
  port1 = {
    interface_id = "eth1/1"
    vlan_key     = "passenger"
    description  = "Passenger WiFi AP uplink"
  }
  port2 = {
    interface_id = "eth1/2"
    vlan_key     = "pos"
    description  = "POS terminal - retail deck"
  }
  port3 = {
    interface_id = "eth1/3"
    vlan_key     = "crew"
    description  = "Crew workstation"
  }
  port4 = {
    interface_id = "eth1/4"
    vlan_key     = "medical"
    description  = "Medical bay device"
  }
}
