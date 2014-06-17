#!/bin/bash

filename=wide_dump_$(date +'%m%d')
./clogin -c 'show ip bgp' -noenable route-views.wide.routeviews.org > $filename
