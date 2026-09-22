CREATE TABLE analytics.fact_orders (
    order_fact_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL,
    date_key INTEGER NOT NULL,
    customer_key BIGINT NOT NULL,
    city_key BIGINT NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    subtotal NUMERIC(14,2) NOT NULL,
    discount_amount NUMERIC(14,2) NOT NULL DEFAULT 0,
    tax_amount NUMERIC(14,2) NOT NULL DEFAULT 0,
    shipping_amount NUMERIC(14,2) NOT NULL DEFAULT 0,
    total_amount NUMERIC(14,2) NOT NULL,
    order_count SMALLINT NOT NULL DEFAULT 1,

    CONSTRAINT uq_fact_orders_order UNIQUE (order_id),

    CONSTRAINT fk_fact_orders_date
        FOREIGN KEY (date_key) REFERENCES analytics.dim_date(date_key),

    CONSTRAINT fk_fact_orders_customer
        FOREIGN KEY (customer_key) REFERENCES analytics.dim_customer(customer_key),

    CONSTRAINT fk_fact_orders_city
        FOREIGN KEY (city_key) REFERENCES analytics.dim_city(city_key),

    CONSTRAINT chk_fact_orders_amounts
        CHECK (
            subtotal >= 0 AND
            discount_amount >= 0 AND
            tax_amount >= 0 AND
            shipping_amount >= 0 AND
            total_amount >= 0
        ),

    CONSTRAINT chk_fact_orders_count
        CHECK (order_count = 1)
);


CREATE TABLE analytics.fact_order_items (
    order_item_fact_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_item_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    date_key INTEGER NOT NULL,
    customer_key BIGINT NOT NULL,
    product_key BIGINT NOT NULL,
    category_key BIGINT NOT NULL,
    supplier_key BIGINT NOT NULL,
    city_key BIGINT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(14,2) NOT NULL,
    discount_amount NUMERIC(14,2) NOT NULL DEFAULT 0,
    line_total NUMERIC(14,2) NOT NULL,

    CONSTRAINT uq_fact_order_items_source UNIQUE (order_item_id),

    CONSTRAINT fk_fact_order_items_date
        FOREIGN KEY (date_key) REFERENCES analytics.dim_date(date_key),

    CONSTRAINT fk_fact_order_items_customer
        FOREIGN KEY (customer_key) REFERENCES analytics.dim_customer(customer_key),

    CONSTRAINT fk_fact_order_items_product
        FOREIGN KEY (product_key) REFERENCES analytics.dim_product(product_key),

    CONSTRAINT fk_fact_order_items_category
        FOREIGN KEY (category_key) REFERENCES analytics.dim_category(category_key),

    CONSTRAINT fk_fact_order_items_supplier
        FOREIGN KEY (supplier_key) REFERENCES analytics.dim_supplier(supplier_key),

    CONSTRAINT fk_fact_order_items_city
        FOREIGN KEY (city_key) REFERENCES analytics.dim_city(city_key),

    CONSTRAINT chk_fact_order_items_measures
        CHECK (
            quantity > 0 AND
            unit_price >= 0 AND
            discount_amount >= 0 AND
            line_total >= 0
        )
);


CREATE TABLE analytics.fact_payments (
    payment_fact_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    payment_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    date_key INTEGER NOT NULL,
    customer_key BIGINT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    payment_amount NUMERIC(14,2) NOT NULL,

    CONSTRAINT uq_fact_payments_source UNIQUE (payment_id),

    CONSTRAINT fk_fact_payments_date
        FOREIGN KEY (date_key) REFERENCES analytics.dim_date(date_key),

    CONSTRAINT fk_fact_payments_customer
        FOREIGN KEY (customer_key) REFERENCES analytics.dim_customer(customer_key),

    CONSTRAINT chk_fact_payments_amount
        CHECK (payment_amount >= 0)
);


CREATE TABLE analytics.fact_inventory (
    inventory_fact_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_key INTEGER NOT NULL,
    product_key BIGINT NOT NULL,
    warehouse_key BIGINT NOT NULL,
    quantity_on_hand INTEGER NOT NULL,
    quantity_reserved INTEGER NOT NULL,
    available_quantity INTEGER NOT NULL,

    CONSTRAINT uq_fact_inventory_snapshot
        UNIQUE (date_key, product_key, warehouse_key),

    CONSTRAINT fk_fact_inventory_date
        FOREIGN KEY (date_key) REFERENCES analytics.dim_date(date_key),

    CONSTRAINT fk_fact_inventory_product
        FOREIGN KEY (product_key) REFERENCES analytics.dim_product(product_key),

    CONSTRAINT fk_fact_inventory_warehouse
        FOREIGN KEY (warehouse_key) REFERENCES analytics.dim_warehouse(warehouse_key),

    CONSTRAINT chk_fact_inventory_quantities
        CHECK (
            quantity_on_hand >= 0 AND
            quantity_reserved >= 0 AND
            available_quantity >= 0 AND
            quantity_reserved <= quantity_on_hand AND
            available_quantity = quantity_on_hand - quantity_reserved
        )
);


CREATE TABLE analytics.fact_returns (
    return_fact_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    return_id BIGINT NOT NULL,
    order_item_id BIGINT NOT NULL,
    date_key INTEGER NOT NULL,
    customer_key BIGINT NOT NULL,
    product_key BIGINT NOT NULL,
    return_quantity INTEGER NOT NULL,
    refund_amount NUMERIC(14,2) NOT NULL,
    return_status VARCHAR(30) NOT NULL,

    CONSTRAINT uq_fact_returns_source UNIQUE (return_id),

    CONSTRAINT fk_fact_returns_date
        FOREIGN KEY (date_key) REFERENCES analytics.dim_date(date_key),

    CONSTRAINT fk_fact_returns_customer
        FOREIGN KEY (customer_key) REFERENCES analytics.dim_customer(customer_key),

    CONSTRAINT fk_fact_returns_product
        FOREIGN KEY (product_key) REFERENCES analytics.dim_product(product_key),

    CONSTRAINT chk_fact_returns_measures
        CHECK (
            return_quantity > 0 AND
            refund_amount >= 0
        )
);