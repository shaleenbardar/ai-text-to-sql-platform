CREATE INDEX IF NOT EXISTS idx_fact_orders_date
    ON analytics.fact_orders (date_key);

CREATE INDEX IF NOT EXISTS idx_fact_orders_customer
    ON analytics.fact_orders (customer_key);

CREATE INDEX IF NOT EXISTS idx_fact_orders_city
    ON analytics.fact_orders (city_key);

CREATE INDEX IF NOT EXISTS idx_fact_orders_status
    ON analytics.fact_orders (order_status);

CREATE INDEX IF NOT EXISTS idx_fact_order_items_date
    ON analytics.fact_order_items (date_key);

CREATE INDEX IF NOT EXISTS idx_fact_order_items_product
    ON analytics.fact_order_items (product_key);

CREATE INDEX IF NOT EXISTS idx_fact_order_items_customer
    ON analytics.fact_order_items (customer_key);

CREATE INDEX IF NOT EXISTS idx_fact_order_items_category
    ON analytics.fact_order_items (category_key);

CREATE INDEX IF NOT EXISTS idx_fact_order_items_supplier
    ON analytics.fact_order_items (supplier_key);

CREATE INDEX IF NOT EXISTS idx_fact_payments_date
    ON analytics.fact_payments (date_key);

CREATE INDEX IF NOT EXISTS idx_fact_payments_customer
    ON analytics.fact_payments (customer_key);

CREATE INDEX IF NOT EXISTS idx_fact_payments_status
    ON analytics.fact_payments (payment_status);

CREATE INDEX IF NOT EXISTS idx_fact_inventory_date
    ON analytics.fact_inventory (date_key);

CREATE INDEX IF NOT EXISTS idx_fact_inventory_product
    ON analytics.fact_inventory (product_key);

CREATE INDEX IF NOT EXISTS idx_fact_inventory_warehouse
    ON analytics.fact_inventory (warehouse_key);

CREATE INDEX IF NOT EXISTS idx_fact_returns_date
    ON analytics.fact_returns (date_key);

CREATE INDEX IF NOT EXISTS idx_fact_returns_customer
    ON analytics.fact_returns (customer_key);

CREATE INDEX IF NOT EXISTS idx_fact_returns_product
    ON analytics.fact_returns (product_key);

-- SCD2 lookup optimization
CREATE INDEX IF NOT EXISTS idx_dim_customer_source_current
    ON analytics.dim_customer (customer_id, is_current);

CREATE INDEX IF NOT EXISTS idx_dim_product_source_current
    ON analytics.dim_product (product_id, is_current);

-- Common dimension filtering
CREATE INDEX IF NOT EXISTS idx_dim_date_year_month
    ON analytics.dim_date (year, month);

CREATE INDEX IF NOT EXISTS idx_dim_product_category
    ON analytics.dim_product (category_key);

CREATE INDEX IF NOT EXISTS idx_dim_product_supplier
    ON analytics.dim_product (supplier_key);