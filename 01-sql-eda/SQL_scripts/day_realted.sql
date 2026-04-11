SELECT alpha.day_of_week,alpha.all,beta.delayed_38,gama.on_time_18 FROM (
SELECT day_of_week, COUNT(*) AS all FROM airport_related
GROUP BY day_of_week
) AS alpha
JOIN (
SELECT day_of_week,ROUND(100*COUNT(*)/SUM(COUNT(*)) OVER(),2) AS delayed_38 FROM airport_related
WHERE taxi_out>38
GROUP BY day_of_week
) AS beta
ON alpha.day_of_week = beta.day_of_week
JOIN(
SELECT day_of_week,ROUND(100*COUNT(*)/SUM(COUNT(*)) OVER(),2) AS on_time_18 FROM airport_related
WHERE taxi_out <18
GROUP BY day_of_week
) AS gama
ON beta.day_of_week=gama.day_of_week
ORDER BY beta.delayed_38 DESC
