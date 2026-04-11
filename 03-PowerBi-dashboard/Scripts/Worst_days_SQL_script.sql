with a AS (SELECT day_of_month,month, AVG(taxi_out) AS average_taxi_out,
STDDEV_POP(taxi_out) AS std_dev_taxi_out,
AVG(sch_dep) AS average_departures_traffic FROM jfk_data 
GROUP BY month,day_of_month
ORDER BY average_taxi_out DESC
LIMIT 10 
), b AS (SELECT month,day_of_month,wind, COUNT(*) AS wind_count,
ROW_NUMBER() OVER ( PARTITION BY month, day_of_month ORDER BY COUNT(*) DESC ) AS rn FROM jfk_data
GROUP BY month,day_of_month,wind )
SELECT a.day_of_month, a.month, ROUND(a.average_taxi_out,2) AS taxi_out_average ,
ROUND(a.std_dev_taxi_out,2) AS taxi_out_standar_deviation,
ROUND(a.average_departures_traffic,2) AS departures_traffic_average,b.wind AS dominant_wind
,b.wind_count AS wind_frequency FROM a 
LEFT JOIN  b
ON a.month=b.month AND a.day_of_month=b.day_of_month AND b.rn=1
ORDER BY average_taxi_out DESC

