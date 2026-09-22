-- ============================================================
-- Warehouses
-- ============================================================

CREATE TABLE warehouses (
    warehouse_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    city_id INTEGER NOT NULL,
    warehouse_name VARCHAR(150) NOT NULL,
    warehouse_code VARCHAR(30) NOT NULL UNIQUE,
    warehouse_status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_warehouses_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
);


-- ============================================================
-- Inventory
-- ============================================================

CREATE TABLE inventory (
    inventory_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_id INTEGER NOT NULL,
    product_id BIGINT NOT NULL,
    quantity_on_hand INTEGER NOT NULL,
    quantity_reserved INTEGER NOT NULL,
    reorder_level INTEGER NOT NULL,
    last_restocked_at TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT uq_inventory_warehouse_product
        UNIQUE (warehouse_id, product_id),

    CONSTRAINT chk_inventory_on_hand
        CHECK (quantity_on_hand >= 0),

    CONSTRAINT chk_inventory_reserved
        CHECK (quantity_reserved >= 0),

    CONSTRAINT chk_inventory_reorder
        CHECK (reorder_level >= 0),

    CONSTRAINT chk_inventory_reserved_limit
        CHECK (quantity_reserved <= quantity_on_hand)
);