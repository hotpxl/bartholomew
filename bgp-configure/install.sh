#!/bin/bash
yum install quagga --assumeyes
mv /etc/quagga/bgpd.conf /etc/quagga/bgpd.conf.old
mv /etc/quagga/vtysh.conf /etc/quagga/vtysh.conf.old
cp bgpd.conf /etc/quagga/
cp vtysh.conf /etc/quagga/
line="0 0 * * * $(pwd)/dump_bgp.sh"
(crontab -l; echo "$line" ) | crontab
