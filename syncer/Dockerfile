FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USERNAME=nominatim
ENV USERHOME=/srv/$USERNAME

RUN apt-get update -qq && \
    apt-get install -y osm2pgsql postgresql-postgis postgresql-postgis-scripts \
                       pkg-config libicu-dev git wget python3-pip && \
    useradd -d $USERHOME -s /bin/bash -m $USERNAME && \
    mkdir -p $USERHOME && mkdir -p /nominatim-data && \
    chown -R $USERNAME:$USERNAME /nominatim-data && \
    chmod -R 755 /nominatim-data && \
    chown -R $USERNAME:$USERNAME $USERHOME

WORKDIR $USERHOME
USER $USERNAME


RUN git clone --depth=1 https://github.com/openstreetmap/Nominatim.git && \
    cd Nominatim && \
    wget -O data/country_osm_grid.sql.gz https://nominatim.org/data/country_grid.sql.gz && \
    pip install --user --upgrade pip --break-system-packages && \
    pip install --user psycopg[binary] falcon uvicorn gunicorn --break-system-packages && \
    pip install --user -e ./packaging/nominatim-db --break-system-packages && \
    pip install --user -e ./packaging/nominatim-api --break-system-packages && \
    pip3 install --user osmium --break-system-packages  # To run replication https://nominatim.org/release-docs/latest/admin/Update/


ENV PATH="$USERHOME/.local/bin:$PATH"

COPY --chown=$USERNAME:$USERNAME ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
