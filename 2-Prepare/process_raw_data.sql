/* Process and clean all data in the RAW schema to the PROC schema */

-- DROP TABLES

DROP TABLE IF EXISTS PROC.ROOFPRINTS CASCADE;
DROP TABLE IF EXISTS PROC.FLOODPLAINS CASCADE;
DROP TABLE IF EXISTS PROC.PARCELS CASCADE;

-- CREATE TABLES

CREATE TABLE PROC.ROOFPRINTS (
	OID SERIAL PRIMARY KEY,
	BLDGTYPE VARCHAR,
	BLDGYEAR INTEGER,
	GEOM GEOMETRY(POLYGON, 2876) NOT NULL
);

CREATE TABLE PROC.FLOODPLAINS (
	OID SERIAL PRIMARY KEY,
	FLOODZONE VARCHAR,
	RISKSCORE INTEGER,
	FROMDATE DATE,
	TODATE DATE,
	GEOM GEOMETRY(POLYGON, 2876) NOT NULL
);

CREATE TABLE PROC.PARCELS (
	OID SERIAL PRIMARY KEY,
	STRADDRESS VARCHAR,
	BLDGYEAR INTEGER,
	GEOM GEOMETRY(POLYGON, 2876) NOT NULL
);

-- INSERT VALUES FROM RAW

INSERT INTO PROC.ROOFPRINTS (BLDGTYPE, BLDGYEAR, GEOM)
SELECT BLDGTYPE,
	BUILDYEAR,
	(ST_DUMP(WKB_GEOMETRY)).GEOM
FROM RAW.ROOFPRINTS;

INSERT INTO PROC.FLOODPLAINS (FLOODZONE, RISKSCORE, FROMDATE, TODATE, GEOM)
SELECT 
	FLOODZONE,
	CASE
		WHEN FLOODZONE = 'HHZ' THEN 4 -- high hazard zone is most dangerous/likely
		WHEN FLOODZONE like 'A%' AND FLOODWAY = 1 THEN 3 -- conveyance zone is next
		WHEN FLOODZONE like 'A%' AND FLOODWAY <> 1 THEN 2 --100 year
		WHEN FLOODZONE in ('X', 'B') THEN 1 -- 500 year
	END RISKSCORE,
	EFFDATE::date,
	INEFFDATE::date,
	(ST_DUMP(WKB_GEOMETRY)).GEOM
FROM RAW.FLOODPLAINS;

INSERT INTO PROC.PARCELS (STRADDRESS, BLDGYEAR, GEOM)
SELECT INITCAP(SITEADDRESS) STRADDRESS,
	BUILDINGYEARPRIM BUILDYEAR,
	(ST_DUMP(WKB_GEOMETRY)).GEOM
FROM RAW.PARCELS;

-- CREATE INDICES

CREATE INDEX IF NOT EXISTS ROOFPRINTS_GEOM_IDX ON PROC.ROOFPRINTS USING GIST(GEOM);
CREATE INDEX IF NOT EXISTS ROOFPRINTS_CENTROID_IDX ON PROC.ROOFPRINTS USING GIST(GEOM);

CREATE INDEX IF NOT EXISTS FLOODPLAINS_GEOM_IDX ON PROC.FLOODPLAINS USING GIST(GEOM);

CREATE INDEX IF NOT EXISTS PARCELS_GEOM_IDX ON PROC.PARCELS USING GIST(GEOM);