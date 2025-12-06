CREATE DATABASE olist;
USE olist;

SELECT COUNT(*) FROM olist_customers_dataset;
SELECT COUNT(*) FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_order_items_dataset;
SELECT COUNT(*) FROM olist_order_payments_dataset;
SELECT COUNT(*) FROM olist_products_dataset;

SHOW TABLES;
DESCRIBE olist_customers_dataset;
DESCRIBE olist_orders_dataset;
DESCRIBE olist_order_items_dataset;
DESCRIBE olist_order_payments_dataset;
DESCRIBE olist_products_dataset;

SELECT 
    c.customer_state,
    SUM(p.payment_value) AS total_revenue
FROM olist_order_payments_dataset p
JOIN olist_orders_dataset o 
    ON p.order_id = o.order_id
JOIN olist_customers_dataset c 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM olist_orders_dataset o
GROUP BY month
ORDER BY month;

SELECT 
    p.product_category_name,
    SUM(oi.price) AS total_sales,
    COUNT(*) AS items_sold
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p 
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT 
    payment_type,
    COUNT(*) AS total_transactions,
    SUM(payment_value) AS total_amount
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;

