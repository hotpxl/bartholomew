#!/usr/bin/env bash
for registry in "apnic" "afrinic" "arin" "lacnic"; do
  wget ftp://ftp.apnic.net/pub/stats/${registry}/delegated-${registry}-extended-latest
done
