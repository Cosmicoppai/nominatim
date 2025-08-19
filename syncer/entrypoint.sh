#!/usr/bin/bash

set -e

nominatim replication --init

while true; do
  echo "Staring Sync"
  nominatim replication --catch-up --threads 10
  nominatim refresh --postcodes
  echo "Sync Done"
  sleep 86400
done