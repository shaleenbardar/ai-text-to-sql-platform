-- Monthly sales summary
CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.mv_monthly_sales AS
SELECT
    d.year,
    d.month,
    SUM(f.quantity) AS units_sold,
    SUM(f.line_total) AS revenue,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM analytics.fact_order_items f
JOIN analytics.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month;


-- Category performance
CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.mv_category_sales AS
SELECT
    c.category_key,
    c.category_id,
    c.category_name,
    SUM(f.quantity) AS units_sold,
    SUM(f.line_total) AS revenue,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM analytics.fact_order_items f
JOIN analytics.dim_category c
    ON f.category_key = c.category_key
GROUP BY
    c.category_key,
    c.category_id,
    c.category_name;


-- Customer sales summary
CREATE MATERIALIZED VIEW IF NOT EXISTS analytics.mv_customer_sales AS
SELECT
    c.customer_key,
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.quantity) AS total_units,
    SUM(f.line_total) AS total_revenue
FROM analytics.fact_order_items f
JOIN analytics.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.customer_id,
    c.first_name,
    c.last_name;