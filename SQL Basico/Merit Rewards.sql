-- SOLUCIÓN EN SQL SERVER
SELECT e.employee_ID, e.name 
FROM employee_information AS e
    INNER JOIN last_quarter_bonus AS l
    ON e.employee_ID = l.employee_ID
WHERE e.division = "HR" AND l.bonus >= 5000 