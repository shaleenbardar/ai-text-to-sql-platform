-- Customer email should be unique
ALTER TABLE public.customers
ADD CONSTRAINT uq_customers_email
UNIQUE (email);

-- Product SKU should be unique
ALTER TABLE public.products
ADD CONSTRAINT uq_products_sku
UNIQUE (sku);

-- Warehouse code should be unique
ALTER TABLE public.warehouses
ADD CONSTRAINT uq_warehouses_code
UNIQUE (warehouse_code);

-- Order item quantity must be positive
ALTER TABLE public.order_items
ADD CONSTRAINT chk_order_items_quantity_positive
CHECK (quantity > 0);

-- Product unit price must be non-negative
ALTER TABLE public.products
ADD CONSTRAINT chk_products_unit_price_nonnegative
CHECK (unit_price >= 0);

-- Inventory quantities must be valid
ALTER TABLE public.inventory
ADD CONSTRAINT chk_inventory_quantities
CHECK (
    quantity_on_hand >= 0
    AND quantity_reserved >= 0
    AND quantity_reserved <= quantity_on_hand
);