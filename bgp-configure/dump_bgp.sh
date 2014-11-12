#!/bin/bash
FILENAME=$(date +"%F_%H%M")_bgp
vtysh -c "show ip bgp" > /tmp/$FILENAME
