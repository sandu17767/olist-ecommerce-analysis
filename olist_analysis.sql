-- Olist e-commerce analysis
-- Focus: delivery performance, revenue, customer behaviour


-- 1. Keep only valid delivered orders
-- We don’t delete data, just filter for analysis

CREATE VIEW clean_delivered_orders AS
SELECT
    order_id,
    customer_id,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM olist_ecommerce.orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date >= order_purchase_timestamp;



-- 2. Calculate delivery time in days per order

CREATE VIEW delivery_time_per_order AS
SELECT
    order_id,
    customer_id,
    DATEDIFF(
        order_delivered_customer_date,
        order_purchase_timestamp
    ) AS delivery_days,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM clean_delivered_orders;



-- 3. Mark orders as late or on-time
-- Late = delivered after the estimated date

CREATE VIEW delivery_reliability AS
SELECT
    order_id,
    customer_id,
    delivery_days,
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN 'Late'
        ELSE 'On-time'
    END AS delivery_status
FROM delivery_time_per_order;



-- 4. Calculate revenue per order
-- Revenue = item price + freight (shipping)

CREATE VIEW order_revenue AS
SELECT
    oi.order_id,
    SUM(oi.price + oi.freight_value) AS order_revenue
FROM olist_ecommerce.order_items oi
GROUP BY oi.order_id;



-- 5. Combine delivery info with revenue
-- This is the main table used for most analysis

CREATE VIEW delivered_orders_with_revenue AS
SELECT
    d.order_id,
    d.customer_id,
    d.delivery_days,
    r.order_revenue
FROM delivery_time_per_order d
JOIN order_revenue r
    ON d.order_id = r.order_id;



-- 6. Group orders by delivery speed
-- Used to compare speed vs revenue

CREATE VIEW delivery_speed_analysis AS
SELECT
    CASE
        WHEN delivery_days <= 7 THEN 'Fast'
        WHEN delivery_days <= 14 THEN 'Medium'
        ELSE 'Slow'
    END AS delivery_speed,
    COUNT(*) AS orders,
    AVG(order_revenue) AS avg_order_value
FROM delivered_orders_with_revenue
GROUP BY delivery_speed;



-- 7. Count how many orders each customer made
-- customer_unique_id is used to track repeat buyers

CREATE VIEW customer_order_count AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id;



-- 8. Classify customers
-- One-time vs repeat

CREATE VIEW customer_type AS
SELECT
    customer_unique_id,
    CASE
        WHEN total_orders = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_segment
FROM customer_order_count;



-- 9. Compare revenue by customer type
-- Helps understand retention value

CREATE VIEW revenue_by_customer_type AS
SELECT
    ct.customer_segment,
    COUNT(DISTINCT dor.order_id) AS orders,
    AVG(dor.order_revenue) AS avg_order_value,
    SUM(dor.order_revenue) AS total_revenue
FROM delivered_orders_with_revenue dor
JOIN olist_ecommerce.orders o
    ON dor.order_id = o.order_id
JOIN olist_ecommerce.customers c
    ON o.customer_id = c.customer_id
JOIN customer_type ct
    ON c.customer_unique_id = ct.customer_unique_id
GROUP BY ct.customer_segment;



-- 10. Check delivery performance by customer type
-- Tests if repeat customers get better delivery

CREATE VIEW delivery_by_customer_type AS
SELECT
    ct.customer_segment,
    AVG(dor.delivery_days) AS avg_delivery_days,
    COUNT(*) AS orders
FROM delivered_orders_with_revenue dor
JOIN olist_ecommerce.orders o
    ON dor.order_id = o.order_id
JOIN olist_ecommerce.customers c
    ON o.customer_id = c.customer_id
JOIN customer_type ct
    ON c.customer_unique_id = ct.customer_unique_id
GROUP BY ct.customer_segment;



-- 11. Delivery performance by state
-- Used to spot regions with slower logistics

CREATE VIEW delivery_by_state AS
SELECT
    c.customer_state,
    COUNT(*) AS total_orders,
    AVG(
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        )
    ) AS avg_delivery_days
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;
