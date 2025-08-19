#!/usr/bin/bash

set -e

nominatim replication --init

while true; do
  sleep 86400
  echo "Staring Sync"
  nominatim replication --catch-up --threads 10
  nominatim refresh --postcodes
  echo "Sync Done"
done