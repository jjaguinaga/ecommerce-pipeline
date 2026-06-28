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

CREATE VIEW avg_order_value AS
WITH segment_totals AS (
SELECT SUM(line_total) AS total_sales, order_id
FROM order_items
GROUP BY order_id
)
SELECT c.segment, ROUND(AVG(s.total_sales)::numeric, 2) AS avg_order_value
FROM segment_totals AS s
INNER JOIN orders AS o
	ON s.order_id = o.order_id
INNER JOIN customers AS c
	ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY 1;

CREATE VIEW state_most_orders AS 
SELECT shipping_state, COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE status = 'completed'
GROUP BY 1
ORDER BY 1 DESC
LIMIT 1;

CREATE VIEW percent_status AS
SELECT status, ROUND(COUNT(order_id) * 100.0 / SUM(COUNT(order_id)) OVER (), 2) AS percent
FROM orders
GROUP BY 1;

CREATE VIEW avg_rating_below_3 AS
SELECT p.product_name, ROUND(AVG(r.rating), 2) AS avg_rating
FROM products AS p
JOIN reviews AS r
	ON p.product_id = r.product_id
GROUP BY 1
HAVING AVG(r.rating) < 3;

CREATE VIEW last_12_months_revenue AS
SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS month, ROUND(SUM(i.line_total)::numeric, 2) AS revenue_total
FROM orders AS o
JOIN order_items AS i
	ON o.order_id = i.order_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY 1
ORDER BY 1;

CREATE VIEW top_spending_customers AS
SELECT c.first_name, c.last_name, c.segment, ROUND(SUM(i.line_total)::numeric, 2) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
	ON c.customer_id = o.customer_id
INNER JOIN order_items AS i
	ON o.order_id = i.order_id
WHERE o.status = 'completed'
GROUP BY 1, 2, 3
ORDER BY 4 DESC
LIMIT 5;

CREATE VIEW repeat_customers AS
SELECT c.customer_id, c.first_name, COUNT(o.customer_id) AS times_ordered
FROM customers AS c
JOIN orders AS o
	ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY 1
HAVING COUNT(o.customer_id) > 1;

CREATE VIEW discount_multiple_purchases AS
SELECT p.category, ROUND(AVG(o.discount_pct)::numeric, 2) AS avg_discount, SUM(o.quantity) AS times_ordered
FROM products AS p
JOIN order_items AS o
	ON p.product_id = o.product_id
GROUP BY 1
ORDER BY 2 DESC;