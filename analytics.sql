CREATE VIEW customers_per_segment AS
SELECT segment, COUNT(customer_id) AS total
FROM customers
GROUP BY 1;

CREATE VIEW top_5_products AS
SELECT p.product_name, SUM(o.quantity) AS total_sold
FROM products AS p
JOIN order_items AS o
	ON p.product_id = o.product_id 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

CREATE VIEW revenue_by_category AS
SELECT p.category, ROUND(SUM(o.line_total)::numeric, 2) AS total
FROM products AS p
JOIN order_items AS o
	ON p.product_id = o.product_id
GROUP BY 1;