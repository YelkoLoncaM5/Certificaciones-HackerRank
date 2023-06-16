-- SOLUCIÓN EN SQL SERVER
SELECT p.SKU, p.product_name 
FROM PRODUCT AS p
    LEFT JOIN INVOICE_ITEM AS i
    ON p.id = i.product_id
WHERE i.invoice_id is null
ORDER BY p.SKU