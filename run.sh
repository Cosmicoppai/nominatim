#!/usr/bin/bash

sudo chown -R 1001:1001 ./nominatim-data
sudo chmod -R 755 ./nominatim-data
mkdir -p ./pg-data

git clone --depth=1 https://github.com/Cosmicoppai/nominatim.git && docker compose up -d --build