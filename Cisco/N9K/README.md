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

❯ ./checks_switch.sh
========================================
 N9K-CORE-1 Cruise Ship Network Status
========================================
--- VLANs (Bridge Domains) ---
  VLAN   10 | MGMT-OOB             | adminSt=active   | operSt=down
  VLAN   40 | ENTERTAINMENT        | adminSt=active   | operSt=down
  VLAN   70 | ENGINE-OT            | adminSt=active   | operSt=down
  VLAN   60 | BRIDGE-NAV           | adminSt=active   | operSt=down
  VLAN   20 | CREW-OPS             | adminSt=active   | operSt=down
  VLAN   30 | PASSENGER-WIFI       | adminSt=active   | operSt=down
  VLAN   80 | MEDICAL              | adminSt=active   | operSt=down
  VLAN   50 | POS-RETAIL           | adminSt=active   | operSt=down
--- SVIs (Layer 3 Interfaces) ---
  vlan60       | adminSt=up       | descr=Bridge and navigation systems
  vlan20       | adminSt=up       | descr=Crew and operations
  vlan40       | adminSt=up       | descr=IPTV and entertainment systems
  vlan70       | adminSt=up       | descr=Engine room and OT systems
  vlan30       | adminSt=up       | descr=Passenger guest WiFi
  vlan10       | adminSt=up       | descr=Out-of-band management
  vlan80       | adminSt=up       | descr=Medical systems
  vlan50       | adminSt=up       | descr=Point of sale and retail
  vlan1        | adminSt=down     | descr=
--- SVI IP Addresses ---
  mgmt0        | 10.10.20.45/24       | type=primary
  vlan50       | 10.0.50.1/24         | type=primary
  vlan40       | 10.0.40.1/24         | type=primary
  vlan80       | 10.0.80.1/24         | type=primary
  vlan10       | 10.0.10.1/24         | type=primary
  vlan60       | 10.0.60.1/24         | type=primary
  vlan20       | 10.0.20.1/24         | type=primary
  vlan70       | 10.0.70.1/24         | type=primary
  vlan30       | 10.0.30.1/24         | type=primary
--- Access Ports ---
  eth1/1     | mode=access   | vlan=vlan-30    | adminSt=up     | descr=Passenger WiFi AP uplink
  eth1/2     | mode=access   | vlan=vlan-50    | adminSt=up     | descr=POS terminal - retail deck
  eth1/3     | mode=access   | vlan=vlan-20    | adminSt=up     | descr=Crew workstation
  eth1/4     | mode=access   | vlan=vlan-80    | adminSt=up     | descr=Medical bay device
========================================

