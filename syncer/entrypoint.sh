#!/usr/bin/bash

set -e

nominatim replication --init

while true; do
  sleep 3600
  nominatim replication --catch-up --threads 10
  nominatim refresh --postcodes
done