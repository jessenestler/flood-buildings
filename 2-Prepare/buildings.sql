DROP TABLE IF EXISTS FLOOD.BUILDINGS CASCADE;

-- create the table from a selection on the sandbox

CREATE TABLE FLOOD.BUILDINGS AS
SELECT OBJECTID,
	FACILITYID,
	DRCOGID,
	BLDGTYPE,
	SUBTYPE,
	BUILDYEAR,
	LIFECYCLE,
	WKB_GEOMETRY GEOM
FROM SANDBOX.BUILDINGS;

-- create spatial index

CREATE INDEX IF NOT EXISTS BUILDINGS_GEOM_IDX ON FLOOD.BUILDINGS USING GIST(GEOM);

-- create sequence and make it the primary key

CREATE SEQUENCE IF NOT EXISTS FLOOD.BUILDINGS_ID_SEQ OWNED BY FLOOD.BUILDINGS.OBJECTID;


ALTER TABLE FLOOD.BUILDINGS
ALTER COLUMN OBJECTID
SET DEFAULT NEXTVAL('FLOOD.BUILDINGS_ID_SEQ'::REGCLASS);


ALTER TABLE FLOOD.BUILDINGS ADD CONSTRAINT BUILDINGS_PK PRIMARY KEY (OBJECTID);

-- alter geometry column to not accept null values

ALTER TABLE FLOOD.BUILDINGS
ALTER COLUMN GEOM
SET NOT NULL;