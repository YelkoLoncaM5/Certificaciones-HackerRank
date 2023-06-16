-- SOLUCIÓN EN SQL SERVER
SELECT
    DATEPART(MONTH,record_date) AS MONTH,
    MAX(CASE WHEN data_type = 'max' THEN data_value ELSE null END) AS max_value,
    MIN(CASE WHEN data_type = 'min' THEN data_value ELSE null END) AS min_value,
    CAST(ROUND(AVG(CASE WHEN data_type = 'avg' THEN CAST(data_value AS FLOAT) ELSE null END),0) AS INT) AS avg_value
FROM temperature_records
GROUP BY DATEPART(MONTH,record_date);

