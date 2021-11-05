#!/bin/bash
ogr2ogr \
-f PostgreSQL \
Pg:"dbname=jessenestler" \
GeoJSON:"https://opendata.arcgis.com/datasets/bfc343d63cf54831810b983b36ce6872_5.geojson" \
-nln "sandbox.floodplains" \
-t_srs "EPSG:2876" \
-overwrite