DROP TABLE IF EXISTS PROC.DISSOLVED_ROOFPRINTS CASCADE;


CREATE TABLE PROC.DISSOLVED_ROOFPRINTS AS 
-- with help from https://gis.stackexchange.com/a/4508/114009
SELECT 0 MULTIROOF,
	SINGLE.BLDGTYPE,
	SINGLE.BLDGYEAR,
	SINGLE.GEOM
FROM PROC.ROOFPRINTS SINGLE
LEFT JOIN PROC.TOUCHING_ROOFPRINTS TOUCH ON ST_INTERSECTS(SINGLE.GEOM, TOUCH.GEOM)
WHERE TOUCH.GEOM IS NULL
UNION ALL
SELECT *
FROM PROC.TOUCHING_ROOFPRINTS;


CREATE INDEX DISSOLVED_ROOFPRINTS_GEOM_IDX ON PROC.DISSOLVED_ROOFPRINTS USING GIST(GEOM);