DROP TABLE IF EXISTS FLOOD.ENRICHEDBUILDINGS CASCADE;


CREATE TABLE FLOOD.ENRICHEDBUILDINGS AS
WITH CENTROIDS AS
	(SELECT *,
	 	ST_POINTONSURFACE(GEOM) POINT_GEOM
	 FROM FLOOD.DISSOLVEDBUILDINGS)
SELECT PAR.STRADDRESS,
	CEN.BLDGTYPE,
	LEAST(CEN.BUILDYEAR, PAR.BUILDYEAR) BUILDYEAR,
	CEN.MULTIROOF,
	CEN.GEOM
FROM CENROIDS CEN
LEFT JOIN FLOOD.PARCELS PAR ON ST_INTERSECTS(CEN.POINT_GEOM, PAR.GEOM);


CREATE INDEX IF NOT EXISTS ENRICHEDBUILDINGS_GEOM_IDX ON FLOOD.ENRICHEDBUILDINGS USING GIST(GEOM);