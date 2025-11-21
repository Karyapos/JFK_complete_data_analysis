SELECT alpha.op_unique_carrier AS carrier_code , alpha.total,
ROUND(beta.ov33*1.0/alpha.total,2) AS ov33_percentage ,
ROUND(gama.un15*1.0/alpha.total,2) AS un15_percentage FROM 
(SELECT op_unique_carrier,COUNT(*) AS total 
FROM airport_related
GROUP BY op_unique_carrier) AS alpha
JOIN
(SELECT op_unique_carrier, COUNT(*) AS ov33 FROM airport_related
WHERE taxi_out>35
GROUP BY op_unique_carrier) AS beta
ON alpha.op_unique_carrier = beta.op_unique_carrier
JOIN (SELECT op_unique_carrier, COUNT(*) AS un15 FROM airport_related
WHERE taxi_out<15
GROUP BY op_unique_carrier
) AS gama
ON alpha.op_unique_carrier=gama.op_unique_carrier
ORDER BY total DESC