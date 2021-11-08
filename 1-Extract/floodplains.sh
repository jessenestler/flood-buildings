#!/bin/bash
ogr2ogr \
-f PostgreSQL \
Pg:"dbname=flood" \
GeoJSON:"https://opendata.arcgis.com/datasets/bfc343d63cf54831810b983b36ce6872_5.geojson" \
-nln "raw.floodplains" \
-t_srs "EPSG:2876" \
-overwrite