SELECT
  row_number() OVER(ORDER BY SUM(vol) DESC) AS rank,
  dt, sum(vol) AS vol
FROM coins
GROUP BY dt
ORDER BY vol DESC
LIMIT 10;