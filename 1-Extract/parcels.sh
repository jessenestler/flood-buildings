#!/bin/bash
ogr2ogr \
-f PostgreSQL \
Pg:"dbname=jessenestler" \
GeoJSON:"https://opendata.arcgis.com/datasets/51d34a6c5c37405cbee54576c63253ee_0.geojson" \
-nln "sandbox.parcels" \
-t_srs "EPSG:2876" \
-overwrite