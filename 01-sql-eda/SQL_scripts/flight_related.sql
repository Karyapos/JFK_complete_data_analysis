SELECT alpha.tail_num AS flight_code, alpha.total,
ROUND(beta.ov35*1.0/alpha.total,2) AS ov35_percentage ,
ROUND(gama.un15*1.0/alpha.total,2) AS un15_percentage  FROM 
(SELECT tail_num,COUNT(*) AS total FROM airport_related
GROUP BY tail_num
HAVING COUNT(*) >30
) AS alpha
JOIN
(SELECT tail_num, COUNT(*) AS ov35 FROM airport_related
WHERE taxi_out >35
GROUP BY tail_num) AS beta
ON alpha.tail_num= beta.tail_num
JOIN ( SELECT tail_num,COUNT(*) AS un15 FROM airport_related
WHERE taxi_out<15
GROUP BY tail_num) AS gama
ON alpha.tail_num= gama.tail_num
ORDER BY un15_percentage DESC
LIMIT 30
