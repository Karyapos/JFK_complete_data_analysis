SELECT alpha.condition,alpha.total,
ROUND(100*beta.ov35/alpha.total,2) AS ov35_perc,
ROUND(100*gama.un15/alpha.total,2) AS un15_perc 

FROM ((SELECT condition,COUNT(*) AS total FROM weather_related
GROUP BY condition)  AS alpha
JOIN
(SELECT condition,COUNT(*) AS ov35 FROM weather_related
WHERE taxi_out>35
GROUP BY condition) AS beta
ON alpha.condition=beta.condition
JOIN (SELECT condition,COUNT(*) AS un15 FROM weather_related
WHERE taxi_out<15
GROUP BY condition) AS gama
ON alpha.condition=gama.condition)
ORDER BY total DESC
LIMIT 10