# Nominatim with PostgreSQL 17 Container

This project provides a containerized setup for running Nominatim with PostgreSQL 17, offering a powerful and flexible geocoding solution.
Along with daily sync from the upstream.

## Overview

Nominatim is an open-source tool to search OpenStreetMap data by name and address (geocoding) and to generate synthetic addresses of OSM points (reverse geocoding).
This setup uses PostgreSQL 17 as the database backend, providing the latest features and performance improvements.

## Prerequisites

- Docker
- Docker Compose
- At least 8GB of RAM (16GB recommended for better performance)
- Sufficient disk space (depends on the size of your OpenStreetMap data)

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/Cosmicoppai/nominatim.git
   cd nominatim
   ```

2. Build and start the containers:
   ```
   docker-compose up -d
   ```

3. Access Nominatim at `http://localhost:8080 / http://localhost:80`

## Configuration

- Database settings and Nominatim settings can be modified in the `.env` file.

## Updating

To update the OpenStreetMap data:

1. Stop the containers:
   ```
   docker-compose down
   ```

2. Remove the old database:
   ```
   docker volume rm nominatim-pg17-container_pgdata
   ```

3. Start the containers and re-import data as described in the Quick Start section.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
Build the setup for fun and quick testing and deployment, a lot of things required to make it production ready.

## Links
- https://nominatim.org/release-docs/develop/admin/Install-on-Ubuntu-24/
- https://nominatim.org/release-docs/develop/admin/Import/
- https://wiki.openstreetmap.org/wiki/Planet.osm#Planet.osm_mirrors
- https://video.osgeo.org/w/9cZiX3fMCtpPwhZgRw3oqa
