USE amazon_project;
-- 1. TOTAL SALES KPI

SELECT 
SUM(payment_value) AS total_sales
FROM olist_order_payments_dataset;

-- 2. TOTAL ORDERS KPI

SELECT 
COUNT(*) AS total_orders
from olist_orders_dataset;

-- 3. AVERAGE ORDERS VALUE KPI

SELECT 
AVG(payment_value) AS avg_order_value
FROM olist_order_payments_dataset;

-- 4. AVERAGE REVIEW SCORE KPI


-- ORDER ANALYSIS 
-- 5. ORDER BY STATUS 
SELECT 
order_status,
COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status;

-- 6. SALES BY PAYMENT TYPE 

SELECT 
payment_type,
SUM(payment_value) AS total_sales
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_sales DESC ;

-- 7 MONTHLY SALES TREND + FORECAST 

SELECT 
YEAR(order_purchase_timestamp) AS order_year,
MONTH(order_purchase_timestamp) AS order_month,
SUM(p.payment_value) AS total_sales
FROM olist_orders_dataset o 
JOIN olist_order_payments_dataset p 
ON o.order_id = p.order_id
GROUP BY order_year, order_month
ORDER BY order_year ,order_month;

-- 8. CUSTOMER ANALYSIS
-- TOP CITIES DATA BY ORDER 
 

-- 9. CUSTOMER SPENDING ANALYSIS

SELECT 
c.customer_id,
SUM(p.payment_value) AS total_spent
FROM  olist_customers_dataset c
JOIN olist_orders_dataset o 
ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p 
ON o. order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;


-- 10. PRODUCT ANALYSIS 

SELECT
oi.product_id,
SUM(oi.price) AS total_revenue
FROM olist_order_items_dataset oi 
GROUP BY oi.product_id
ORDER BY total_revenue DESC;

-- 11 SHIPPING COST ANALYSIS

SELECT
product_id,
AVG(freight_value) AS avg_shipping_cost
FROM olist_order_items_dataset
GROUP BY product_id
ORDER BY avg_shipping_cost DESC;


-- 12. REVIEW SCORE BY ORDER STATUS 

SELECT
o.order_status,
AVG(r.review_score) AS avg_review
FROM olist_orders_dataset o 
JOIN olist_order_reviews_dataset r 
ON o.order_id = r.order_id
GROUP BY o.order_status
ORDER BY avg_review DESC;

-- 13. REVIEW DISTRIBUTION

SELECT 
review_score,
COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset
GROUP BY review_score
ORDER BY review_score;

-- 14. DELIVERY ANALYSIS AVERAGE DELIVERY DAYS

SELECT 
AVG(DATEDIFF(order_delivered_customer_date
, order_purchase_timestamp)) AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;

-- 15. DELIVERY DAYS BY STATUS

SELECT
order_status,
AVG(DATEDIFF(order_delivered_customer_date,
order_purchase_timestamp)) AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date
IS NOT NULL
GROUP BY order_status;

-- 16. MULTI PRODUCT  QUERY
SELECT
order_id,
COUNT(product_id) AS total_products
FROM olist_order_items_dataset
GROUP BY order_id
HAVING total_products > 1;


-- 17. MONTHLY SALE ANALYSIS

SELECT 
YEAR(o.order_purchase_timestamp) AS order_year,
MONTHNAME(o.order_purchase_timestamp) AS order_monthname,
SUM(payment_value) AS monthly_sales 
FROM olist_orders_dataset o 
JOIN olist_order_payments_dataset p 
ON o.order_id = p.order_id
GROUP BY 
YEAR(o.order_purchase_timestamp),
MONTHNAME(o.order_purchase_timestamp)
ORDER BY
order_year,
order_monthname;
