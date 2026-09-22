-- Customer lookups
CREATE INDEX IF NOT EXISTS idx_customers_city_id
    ON public.customers (city_id);

CREATE INDEX IF NOT EXISTS idx_customers_email
    ON public.customers (email);

-- Product lookups
CREATE INDEX IF NOT EXISTS idx_products_category_id
    ON public.products (category_id);

CREATE INDEX IF NOT EXISTS idx_products_supplier_id
    ON public.products (supplier_id);

CREATE INDEX IF NOT EXISTS idx_products_sku
    ON public.products (sku);

-- Orders
CREATE INDEX IF NOT EXISTS idx_orders_customer_id
    ON public.orders (customer_id);

CREATE INDEX IF NOT EXISTS idx_orders_order_date
    ON public.orders (order_date);

CREATE INDEX IF NOT EXISTS idx_orders_status
    ON public.orders (order_status);

CREATE INDEX IF NOT EXISTS idx_orders_coupon_id
    ON public.orders (coupon_id);

-- Order items
CREATE INDEX IF NOT EXISTS idx_order_items_order_id
    ON public.order_items (order_id);

CREATE INDEX IF NOT EXISTS idx_order_items_product_id
    ON public.order_items (product_id);

-- Payments
CREATE INDEX IF NOT EXISTS idx_payments_order_id
    ON public.payments (order_id);

CREATE INDEX IF NOT EXISTS idx_payments_status
    ON public.payments (payment_status);

-- Shipments
CREATE INDEX IF NOT EXISTS idx_shipments_warehouse_id
    ON public.shipments (warehouse_id);

CREATE INDEX IF NOT EXISTS idx_shipments_status
    ON public.shipments (shipment_status);

-- Returns
CREATE INDEX IF NOT EXISTS idx_returns_order_item_id
    ON public.returns (order_item_id);

-- Inventory
CREATE INDEX IF NOT EXISTS idx_inventory_product_id
    ON public.inventory (product_id);

CREATE INDEX IF NOT EXISTS idx_inventory_warehouse_id
    ON public.inventory (warehouse_id);

-- Reviews
CREATE INDEX IF NOT EXISTS idx_reviews_product_id
    ON public.reviews (product_id);

CREATE INDEX IF NOT EXISTS idx_reviews_customer_id
    ON public.reviews (customer_id);

-- Cities / suppliers / warehouses
CREATE INDEX IF NOT EXISTS idx_cities_country_id
    ON public.cities (country_id);

CREATE INDEX IF NOT EXISTS idx_suppliers_city_id
    ON public.suppliers (city_id);

CREATE INDEX IF NOT EXISTS idx_warehouses_city_id
    ON public.warehouses (city_id);