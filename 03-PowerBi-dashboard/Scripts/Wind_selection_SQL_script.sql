SELECT * FROM (SELECT DISTINCT(wind), COUNT(taxi_out),AVG(taxi_out) FROM weather_data
GROUP BY wind
ORDER BY avg DESC)
WHERE (avg <20.36 OR avg>21.36 OR wind = 'N') AND count>500