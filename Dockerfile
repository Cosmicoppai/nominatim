FROM ubuntu:24.04

EXPOSE 8080

ENV DEBIAN_FRONTEND=noninteractive
ENV USERNAME=nominatim
ENV USERHOME=/srv/$USERNAME

RUN apt-get update -qq && \
    apt-get install -y osm2pgsql postgresql-postgis postgresql-postgis-scripts \
                       pkg-config libicu-dev git wget python3-pip && \
    useradd -d $USERHOME -s /bin/bash -m $USERNAME && \
    mkdir -p $USERHOME && \
    chown -R $USERNAME:$USERNAME $USERHOME

USER $USERNAME
WORKDIR $USERHOME

RUN git clone https://github.com/openstreetmap/Nominatim.git && \
    cd Nominatim && \
    wget -O data/country_osm_grid.sql.gz https://nominatim.org/data/country_grid.sql.gz && \
    pip install --user --upgrade pip --break-system-packages && \
    pip install --user psycopg[binary] falcon uvicorn gunicorn --break-system-packages && \
    pip install --user -e ./packaging/nominatim-db --break-system-packages && \
    pip install --user -e ./packaging/nominatim-api --break-system-packages

ENV PATH="$USERHOME/.local/bin:$PATH"

COPY --chown=$USERNAME:$USERNAME ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]