-- 1. Order-level analytics
CREATE OR REPLACE VIEW analytics.v_order_summary AS
SELECT
    f.order_id,
    d.full_date AS order_date,
    d.year,
    d.month,
    c.customer_id,
    c.first_name,
    c.last_name,
    city.city_name,
    f.order_status,
    f.subtotal,
    f.discount_amount,
    f.tax_amount,
    f.shipping_amount,
    f.total_amount
FROM analytics.fact_orders f
JOIN analytics.dim_date d
    ON f.date_key = d.date_key
JOIN analytics.dim_customer c
    ON f.customer_key = c.customer_key
JOIN analytics.dim_city city
    ON f.city_key = city.city_key;


-- 2. Product sales analytics
CREATE OR REPLACE VIEW analytics.v_product_sales AS
SELECT
    p.product_id,
    p.sku,
    p.product_name,
    cat.category_name,
    s.supplier_name,
    d.year,
    d.month,
    SUM(f.quantity) AS units_sold,
    SUM(f.line_total) AS revenue,
    AVG(f.unit_price) AS average_unit_price
FROM analytics.fact_order_items f
JOIN analytics.dim_product p
    ON f.product_key = p.product_key
JOIN analytics.dim_category cat
    ON f.category_key = cat.category_key
JOIN analytics.dim_supplier s
    ON f.supplier_key = s.supplier_key
JOIN analytics.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    p.product_id,
    p.sku,
    p.product_name,
    cat.category_name,
    s.supplier_name,
    d.year,
    d.month;


-- 3. Customer sales analytics
CREATE OR REPLACE VIEW analytics.v_customer_sales AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    city.city_name,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.line_total) AS total_revenue,
    SUM(f.quantity) AS total_units
FROM analytics.fact_order_items f
JOIN analytics.dim_customer c
    ON f.customer_key = c.customer_key
JOIN analytics.dim_city city
    ON c.city_key = city.city_key
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    city.city_name;


-- 4. Inventory status
CREATE OR REPLACE VIEW analytics.v_inventory_status AS
SELECT
    p.product_id,
    p.sku,
    p.product_name,
    w.warehouse_id,
    w.warehouse_code,
    w.warehouse_name,
    city.city_name,
    f.quantity_on_hand,
    f.quantity_reserved,
    f.available_quantity,
    d.full_date AS snapshot_date
FROM analytics.fact_inventory f
JOIN analytics.dim_product p
    ON f.product_key = p.product_key
JOIN analytics.dim_warehouse w
    ON f.warehouse_key = w.warehouse_key
JOIN analytics.dim_city city
    ON w.city_key = city.city_key
JOIN analytics.dim_date d
    ON f.date_key = d.date_key;


-- 5. Payment analytics
CREATE OR REPLACE VIEW analytics.v_payment_summary AS
SELECT
    d.full_date AS payment_date,
    d.year,
    d.month,
    f.payment_method,
    f.payment_status,
    COUNT(*) AS payment_count,
    SUM(f.payment_amount) AS total_payment_amount
FROM analytics.fact_payments f
JOIN analytics.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.full_date,
    d.year,
    d.month,
    f.payment_method,
    f.payment_status;