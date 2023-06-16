-- SOLUCIÓN EN SQL SERVER

--SOLUCION CON SUBQUERY
SELECT *
FROM (
    SELECT 
        user_account_id,
        ua.first_name,
        ua.last_name,
        customer_id,
        customer_name,
        ROW_NUMBER() OVER (PARTITION BY user_account_id, customer_id 
        ORDER BY user_account_id, customer_id) AS fila#
    FROM contact AS c
    JOIN customer AS cust ON cust.id = c.customer_id
    JOIN user_account AS ua ON ua.id = c.user_account_id
) AS subquery
WHERE fila# = 2
ORDER BY user_account_id, customer_id;

--SOLUCION CON CTE
WITH numero_fila AS (
    SELECT 
        user_account_id,
        ua.first_name,
        ua.last_name,
        customer_id,
        customer_name,
        ROW_NUMBER() OVER(PARTITION BY user_account_id, customer_id ORDER BY 
        user_account_id, customer_id) AS fila#
    FROM contact AS c
    JOIN customer AS cust ON cust.id = c.customer_id
    JOIN user_account AS ua ON ua.id = c.user_account_id
    
)
SELECT * FROM numero_fila
WHERE fila# = 2
ORDER BY user_account_id,customer_id