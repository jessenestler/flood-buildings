DROP TABLE IF EXISTS PROC.PARCELS CASCADE;

-- create the table

CREATE TABLE PROC.PARCELS (
	OID SERIAL PRIMARY KEY,
	STRADDRESS VARCHAR,
	BLDGYEAR INTEGER,
	GEOM GEOMETRY(POLYGON, 2876) NOT NULL
);

-- insert into table from raw data

INSERT INTO PROC.PARCELS (STRADDRESS, BLDGYEAR, GEOM)
SELECT INITCAP(SITEADDRESS) STRADDRESS,
	BUILDINGYEARPRIM BUILDYEAR,
	(ST_DUMP(WKB_GEOMETRY)).GEOM
FROM RAW.PARCELS;

-- create spatial index

CREATE INDEX IF NOT EXISTS PARCELS_GEOM_IDX ON PROC.PARCELS USING GIST(GEOM);