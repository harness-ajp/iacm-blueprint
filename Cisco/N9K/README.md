## OpenTofu and Networking

# Background
This example OpenTofu project will provision networks to a Nexus 9K

# Setup
1.) Sign up here for access to free resources:  https://developer.cisco.com/site/sandbox/

2.) In the file terraform.tfvars update variables `nxos_username` and `nxos_password`

# Ex
tofu init
tofu plan
tofu apply

You can check the status of the network by executing the check_status.sh script.
Output will look like this:

# N9K-CORE-1 Cruise Ship Network Status

## VLANs (Bridge Domains)

| VLAN | Name | Admin State | Oper State |
|------|------|-------------|------------|
| 10 | MGMT-OOB | active | down |
| 20 | CREW-OPS | active | down |
| 30 | PASSENGER-WIFI | active | down |
| 40 | ENTERTAINMENT | active | down |
| 50 | POS-RETAIL | active | down |
| 60 | BRIDGE-NAV | active | down |
| 70 | ENGINE-OT | active | down |
| 80 | MEDICAL | active | down |

## SVIs (Layer 3 Interfaces)

| Interface | Admin State | Description |
|-----------|-------------|-------------|
| vlan10 | up | Out-of-band management |
| vlan20 | up | Crew and operations |
| vlan30 | up | Passenger guest WiFi |
| vlan40 | up | IPTV and entertainment systems |
| vlan50 | up | Point of sale and retail |
| vlan60 | up | Bridge and navigation systems |
| vlan70 | up | Engine room and OT systems |
| vlan80 | up | Medical systems |
| vlan1 | down | — |

## SVI IP Addresses

| Interface | IP Address | Type |
|-----------|------------|------|
| mgmt0 | 10.10.20.45/24 | primary |
| vlan10 | 10.0.10.1/24 | primary |
| vlan20 | 10.0.20.1/24 | primary |
| vlan30 | 10.0.30.1/24 | primary |
| vlan40 | 10.0.40.1/24 | primary |
| vlan50 | 10.0.50.1/24 | primary |
| vlan60 | 10.0.60.1/24 | primary |
| vlan70 | 10.0.70.1/24 | primary |
| vlan80 | 10.0.80.1/24 | primary |

## Access Ports

| Interface | Mode | VLAN | Admin State | Description |
|-----------|------|------|-------------|-------------|
| eth1/1 | access | vlan-30 | up | Passenger WiFi AP uplink |
| eth1/2 | access | vlan-50 | up | POS terminal - retail deck |
| eth1/3 | access | vlan-20 | up | Crew workstation |
| eth1/4 | access | vlan-80 | up | Medical bay device |
