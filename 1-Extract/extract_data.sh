#!/bin/bash

# roofprints
echo "Extracting roofprints..."
ogr2ogr \
-f PostgreSQL \
Pg:"dbname=flood" \
GeoJSON:"https://opendata.arcgis.com/datasets/0d43652d038a4a0dbca68f0501151bb0_0.geojson" \
-nln "raw.roofprints" \
-t_srs "EPSG:2876" \
-overwrite

# floodplains
echo "Extracting floodplains..."
ogr2ogr \
-f PostgreSQL \
Pg:"dbname=flood" \
GeoJSON:"https://opendata.arcgis.com/datasets/bfc343d63cf54831810b983b36ce6872_5.geojson" \
-nln "raw.floodplains" \
-t_srs "EPSG:2876" \
-overwrite

# parcels
echo "Extracting parcels..."
ogr2ogr \
-f PostgreSQL \
Pg:"dbname=flood" \
GeoJSON:"https://opendata.arcgis.com/datasets/51d34a6c5c37405cbee54576c63253ee_0.geojson" \
-nln "raw.parcels" \
-t_srs "EPSG:2876" \
-overwrite