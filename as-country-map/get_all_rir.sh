#!/usr/bin/env bash
mkdir -p data
cd data
for registry in "ripencc"; do
  rm -rf delegated-${registry}-extended-latest
  axel -n 64 -a ftp://ftp.ripe.net/pub/stats/${registry}/delegated-${registry}-extended-latest
done
