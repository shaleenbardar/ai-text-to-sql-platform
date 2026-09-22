-- ============================================================
-- Coupons
-- ============================================================

CREATE TABLE coupons (
    coupon_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    coupon_code VARCHAR(50) NOT NULL UNIQUE,
    discount_type VARCHAR(20) NOT NULL,
    discount_value NUMERIC(12,2) NOT NULL,
    minimum_order_amount NUMERIC(14,2),
    maximum_discount_amount NUMERIC(14,2),
    valid_from TIMESTAMP NOT NULL,
    valid_until TIMESTAMP NOT NULL,
    coupon_status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_coupons_discount_value
        CHECK (discount_value >= 0),

    CONSTRAINT chk_coupons_min_order
        CHECK (minimum_order_amount IS NULL OR minimum_order_amount >= 0),

    CONSTRAINT chk_coupons_max_discount
        CHECK (maximum_discount_amount IS NULL OR maximum_discount_amount >= 0),

    CONSTRAINT chk_coupons_dates
        CHECK (valid_until > valid_from)
);


-- ============================================================
-- Add Coupon Foreign Key to Orders
-- ============================================================

ALTER TABLE orders
ADD CONSTRAINT fk_orders_coupon
    FOREIGN KEY (coupon_id)
    REFERENCES coupons(coupon_id);


-- ============================================================
-- Payments
-- ============================================================

CREATE TABLE payments (
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    amount NUMERIC(14,2) NOT NULL,
    transaction_reference VARCHAR(100) UNIQUE,
    payment_date TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT chk_payments_amount
        CHECK (amount >= 0)
);


-- ============================================================
-- Shipments
-- ============================================================

CREATE TABLE shipments (
    shipment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL UNIQUE,
    warehouse_id INTEGER NOT NULL,
    carrier_name VARCHAR(100),
    tracking_number VARCHAR(100) UNIQUE,
    shipment_status VARCHAR(30) NOT NULL,
    shipped_at TIMESTAMP,
    delivered_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_shipments_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_shipments_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
);


-- ============================================================
-- Returns
-- ============================================================

CREATE TABLE returns (
    return_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_item_id BIGINT NOT NULL,
    return_quantity INTEGER NOT NULL,
    return_reason VARCHAR(255),
    return_status VARCHAR(30) NOT NULL,
    refund_amount NUMERIC(14,2) NOT NULL,
    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_returns_order_item
        FOREIGN KEY (order_item_id)
        REFERENCES order_items(order_item_id),

    CONSTRAINT chk_returns_quantity
        CHECK (return_quantity > 0),

    CONSTRAINT chk_returns_refund
        CHECK (refund_amount >= 0)
);