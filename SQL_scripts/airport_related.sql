SELECT ROUND(AVG(taxi_out),2) AS taxi_out ,ROUND(AVG(distance),2) AS distance,
ROUND(AVG(sch_dep),2) AS departures,ROUND(AVG(sch_arr),2) AS arrivals FROM airport_related
WHERE  taxi_out <15
UNION ALL 
SELECT ROUND(AVG(taxi_out),2) AS taxi_out ,ROUND(AVG(distance),2) AS distance,
ROUND(AVG(sch_dep),2) AS departures,ROUND(AVG(sch_arr),2) AS arrivals FROM airport_related
WHERE  taxi_out <28
UNION ALL 
SELECT ROUND(AVG(taxi_out),2) AS taxi_out ,ROUND(AVG(distance),2) AS distance,
ROUND(AVG(sch_dep),2) AS departures,ROUND(AVG(sch_arr),2) AS arrivals FROM airport_related
WHERE  taxi_out >17
UNION ALL 
SELECT ROUND(AVG(taxi_out),2) AS taxi_out ,ROUND(AVG(distance),2) AS distance,
ROUND(AVG(sch_dep),2) AS departures,ROUND(AVG(sch_arr),2) AS arrivals FROM airport_related
UNION ALL 
SELECT ROUND(AVG(taxi_out),2) AS taxi_out ,ROUND(AVG(distance),2) AS distance,
ROUND(AVG(sch_dep),2) AS departures,ROUND(AVG(sch_arr),2) AS arrivals FROM airport_related
WHERE taxi_out>25
UNION ALL 
SELECT ROUND(AVG(taxi_out),2) AS taxi_out ,ROUND(AVG(distance),2) AS distance,
ROUND(AVG(sch_dep),2) AS departures,ROUND(AVG(sch_arr),2) AS arrivals FROM airport_related
WHERE taxi_out>35

ORDER BY taxi_out



