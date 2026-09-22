-- ============================================================
-- DB-009 Performance Testing
-- ============================================================

-- 1. Order lookup by customer
EXPLAIN ANALYZE
SELECT *
FROM public.orders
WHERE customer_id = 1000;


-- 2. Orders filtered by date
EXPLAIN ANALYZE
SELECT
    COUNT(*)
FROM public.orders
WHERE order_date >= DATE '2026-01-01';


-- 3. Product sales aggregation
EXPLAIN ANALYZE
SELECT
    p.product_name,
    SUM(f.line_total) AS revenue
FROM analytics.fact_order_items f
JOIN analytics.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY revenue DESC;


-- 4. Monthly revenue
EXPLAIN ANALYZE
SELECT
    d.year,
    d.month,
    SUM(f.line_total) AS revenue
FROM analytics.fact_order_items f
JOIN analytics.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;