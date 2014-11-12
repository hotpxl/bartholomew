#!/bin/bash
yum install quagga --assumeyes
mv -f /etc/quagga/bgpd.conf /etc/quagga/bgpd.conf.old 2> /dev/null
mv -f /etc/quagga/vtysh.conf /etc/quagga/vtysh.conf.old 2> /dev/null
cp -f bgpd.conf /etc/quagga/
cp -f vtysh.conf /etc/quagga/
service bgpd start
line="0 0 * * * $(pwd)/dump_bgp.sh"
(crontab -l 2> /dev/null; echo "$line") | crontab
