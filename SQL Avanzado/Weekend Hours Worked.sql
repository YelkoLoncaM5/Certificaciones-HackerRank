-- SOLUCIÓN EN SQL SERVER

--SOLUCION CON SUBQUERY
SELECT
    emp_id,
    SUM(hours_worked) AS hours_worked
FROM (
    SELECT
        emp_id,
        CASE
            WHEN DATEPART(minute, TIMESTAMP) >= DATEPART(minute, LAG(TIMESTAMP) OVER (PARTITION BY CAST(TIMESTAMP AS date), emp_id ORDER BY TIMESTAMP))
                THEN DATEPART(hour, TIMESTAMP) - DATEPART(hour, LAG(TIMESTAMP) OVER (PARTITION BY CAST(TIMESTAMP AS date), emp_id ORDER BY TIMESTAMP))
            ELSE DATEPART(hour, TIMESTAMP) - DATEPART(hour, LAG(TIMESTAMP) OVER (PARTITION BY CAST(TIMESTAMP AS date), emp_id ORDER BY TIMESTAMP)) - 1
        END AS hours_worked
    FROM attendance
    WHERE DATEPART(weekday, TIMESTAMP) IN (7, 1)
) AS subquery
GROUP BY emp_id
ORDER BY hours_worked DESC;

--SOLUCION CON CTE
WITH hours_worked AS (
SELECT
      emp_id,
        CASE 
       WHEN DATEPART(minute,TIMESTAMP) >= DATEPART(minute,lag(TIMESTAMP) OVER(PARTITION BY CAST(TIMESTAMP AS date),emp_id ORDER BY TIMESTAMP)) 
       THEN datepart(hour,timestamp) - datepart(hour,lag(TIMESTAMP) OVER(PARTITION BY CAST(TIMESTAMP AS date),emp_id ORDER BY TIMESTAMP)) 
        ELSE datepart(hour,TIMESTAMP) - datepart(hour,lag(TIMESTAMP) OVER(PARTITION BY CAST(TIMESTAMP AS date),emp_id ORDER BY TIMESTAMP)) - 1
       END AS hours_worked
FROM   attendance
WHERE  datepart(weekday,TIMESTAMP) IN(7,1)
)
SELECT
   emp_id,
      SUM(hours_worked) AS hours_worked
FROM  hours_worked
GROUP BY emp_id
ORDER BY hours_worked DESC