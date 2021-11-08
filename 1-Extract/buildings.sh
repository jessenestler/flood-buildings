#!/bin/bash
ogr2ogr \
-f PostgreSQL \
Pg:"dbname=flood" \
GeoJSON:"https://opendata.arcgis.com/datasets/0d43652d038a4a0dbca68f0501151bb0_0.geojson" \
-nln "raw.roofprints" \
-t_srs "EPSG:2876" \
-overwrite