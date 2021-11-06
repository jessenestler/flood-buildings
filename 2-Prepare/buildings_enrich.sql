DROP TABLE IF EXISTS FLOOD.ENRICHEDBUILDINGS CASCADE;


CREATE TABLE FLOOD.ENRICHEDBUILDINGS AS
WITH CENTROIDS AS
	(SELECT *,
	 	ST_POINTONSURFACE(GEOM) POINT_GEOM
	 FROM FLOOD.DISSOLVEDBUILDINGS)
SELECT ROW_NUMBER() OVER (ORDER BY CEN.BUILDYEAR) ID,
	PAR.STRADDRESS,
	CEN.BLDGTYPE,
	LEAST(CEN.BUILDYEAR, PAR.BUILDYEAR) BUILDYEAR,
	CEN.MULTIROOF,
	CEN.GEOM
FROM CENTROIDS CEN
LEFT JOIN FLOOD.PARCELS PAR ON ST_INTERSECTS(CEN.POINT_GEOM, PAR.GEOM);

-- create spatial index

CREATE INDEX IF NOT EXISTS ENRICHEDBUILDINGS_GEOM_IDX ON FLOOD.ENRICHEDBUILDINGS USING GIST(GEOM);

-- create sequence and make it the primary key

CREATE SEQUENCE IF NOT EXISTS FLOOD.ENRICHEDBUILDINGS_ID_SEQ OWNED BY FLOOD.ENRICHEDBUILDINGS.ID;


ALTER TABLE FLOOD.ENRICHEDBUILDINGS
ALTER COLUMN ID
SET DEFAULT NEXTVAL('FLOOD.ENRICHEDBUILDINGS_ID_SEQ'::REGCLASS);


ALTER TABLE FLOOD.ENRICHEDBUILDINGS ADD CONSTRAINT ENRICHEDBUILDINGS_PK PRIMARY KEY (ID);