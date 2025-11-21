SELECT alpha.dest,alpha.total,ROUND(beta.ov35*100.0/alpha.total,2) AS ov35,
ROUND(100.0*gama.un15/alpha.total,2) AS un15
FROM (SELECT dest,COUNT(*) AS total FROM airport_related
GROUP BY dest ) AS alpha
JOIN 
(SELECT dest,COUNT(*) AS ov35 FROM airport_related
WHERE taxi_out >35
GROUP BY dest) AS beta
ON alpha.dest=beta.dest
JOIN 
(SELECT dest,COUNT(*) AS un15 FROM airport_related
WHERE taxi_out < 15
GROUP BY dest) AS gama
ON alpha.dest=gama.dest

ORDER BY un15 DESC
