#!/bin/bash

# Get auth token
TOKEN=$(curl -sk -X POST \
  https://sbx-nxos-mgmt.cisco.com/api/aaaLogin.json \
  -H "Content-Type: application/json" \
  -d '{"aaaUser":{"attributes":{"name":"ajrockwad","pwd":"t2ib--5pfH6HCvk"}}}' \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['imdata'][0]['aaaLogin']['attributes']['token'])")

echo "========================================"
echo " N9K-CORE-1 Cruise Ship Network Status"
echo "========================================"

echo ""
echo "--- VLANs (Bridge Domains) ---"
curl -sk \
  -H "Cookie: APIC-Cookie=$TOKEN" \
  "https://sbx-nxos-mgmt.cisco.com/api/class/l2BD.json" \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
for item in data['imdata']:
    bd = item['l2BD']['attributes']
    if bd['id'] != '1':
        print(f\"  VLAN {bd['id']:>4} | {bd['name']:<20} | adminSt={bd['adminSt']:<8} | operSt={bd['operSt']}\")
"

echo ""
echo "--- SVIs (Layer 3 Interfaces) ---"
curl -sk \
  -H "Cookie: APIC-Cookie=$TOKEN" \
  "https://sbx-nxos-mgmt.cisco.com/api/class/sviIf.json" \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
for item in data['imdata']:
    svi = item['sviIf']['attributes']
    print(f\"  {svi['id']:<12} | adminSt={svi['adminSt']:<8} | descr={svi['descr']}\")
"

echo ""
echo "--- SVI IP Addresses ---"
curl -sk \
  -H "Cookie: APIC-Cookie=$TOKEN" \
  "https://sbx-nxos-mgmt.cisco.com/api/class/ipv4Addr.json" \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
for item in data['imdata']:
    addr = item['ipv4Addr']['attributes']
    intf = addr['dn'].split('/')[4].replace('if-[','').replace(']','')
    print(f\"  {intf:<12} | {addr['addr']:<20} | type={addr['type']}\")
"

echo ""
echo "--- Access Ports ---"
curl -sk \
  -H "Cookie: APIC-Cookie=$TOKEN" \
  "https://sbx-nxos-mgmt.cisco.com/api/class/l1PhysIf.json?query-target-filter=and(eq(l1PhysIf.mode,\"access\"),ne(l1PhysIf.accessVlan,\"vlan-1\"))" \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
for item in data['imdata']:
    intf = item['l1PhysIf']['attributes']
    print(f\"  {intf['id']:<10} | mode={intf['mode']:<8} | vlan={intf['accessVlan']:<10} | adminSt={intf['adminSt']:<6} | descr={intf['descr']}\")
"

echo ""
echo "========================================"
