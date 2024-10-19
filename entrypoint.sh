#!/usr/bin/bash

set -e

until pg_isready -h pg -p 5432 -U "$USERNAME"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 10
done

cd /nominatim-data

if [[ ! $PBF_URL ]]; then
  echo "Meh, pass some shit to load. add PBF_URL in .env or pass via -e"
fi


if [ ! -f ./data.pbf ]; then
    wget -O data.pbf $PBF_URL
    wget https://nominatim.org/data/wikimedia-importance.csv.gz
    wget -O secondary_importance.sql.gz https://nominatim.org/data/wikimedia-secondary-importance.sql.gz
    wget https://nominatim.org/data/gb_postcodes.csv.gz
    wget https://nominatim.org/data/us_postcodes.csv.gz

    echo "Starting Nominatim import..."
    NOMINATIM_DATABASE_DSN="pgsql:host=pg;dbname=nominatim;user=${USERNAME};password=${POSTGRES_PASSWORD}" nominatim import \
    --osm-file ./data.pbf \
    --project-dir . \
    2>&1 | tee setup.log
fi


exec gunicorn -b 0.0.0.0:8080 -w 64 -k uvicorn.workers.UvicornWorker nominatim_api.server.falcon.server:run_wsgi
