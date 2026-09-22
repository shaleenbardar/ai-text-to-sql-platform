CREATE SCHEMA IF NOT EXISTS analytics;

CREATE TABLE analytics.dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter INTEGER NOT NULL,
    year INTEGER NOT NULL,
    week INTEGER NOT NULL,
    day_of_week INTEGER NOT NULL,
    day_name VARCHAR(20) NOT NULL
);

CREATE TABLE analytics.dim_city (
    city_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    city_id INTEGER NOT NULL,
    city_name VARCHAR(150) NOT NULL,
    country_id INTEGER NOT NULL,
    country_code CHAR(2) NOT NULL,
    country_name VARCHAR(150) NOT NULL,
    CONSTRAINT uq_dim_city_source UNIQUE (city_id)
);

CREATE TABLE analytics.dim_category (
    category_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id INTEGER NOT NULL,
    category_name VARCHAR(150) NOT NULL,
    description TEXT,
    CONSTRAINT uq_dim_category_source UNIQUE (category_id)
);

CREATE TABLE analytics.dim_supplier (
    supplier_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_id INTEGER NOT NULL,
    supplier_name VARCHAR(200) NOT NULL,
    city_key BIGINT NOT NULL,
    supplier_status VARCHAR(30) NOT NULL,
    CONSTRAINT uq_dim_supplier_source UNIQUE (supplier_id),
    CONSTRAINT fk_dim_supplier_city
        FOREIGN KEY (city_key) REFERENCES analytics.dim_city(city_key)
);

CREATE TABLE analytics.dim_warehouse (
    warehouse_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    warehouse_id INTEGER NOT NULL,
    warehouse_code VARCHAR(50) NOT NULL,
    warehouse_name VARCHAR(200) NOT NULL,
    city_key BIGINT NOT NULL,
    warehouse_status VARCHAR(30) NOT NULL,
    CONSTRAINT uq_dim_warehouse_source UNIQUE (warehouse_id),
    CONSTRAINT uq_dim_warehouse_code UNIQUE (warehouse_code),
    CONSTRAINT fk_dim_warehouse_city
        FOREIGN KEY (city_key) REFERENCES analytics.dim_city(city_key)
);

CREATE TABLE analytics.dim_customer (
    customer_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    city_key BIGINT NOT NULL,
    customer_status VARCHAR(30) NOT NULL,
    effective_from DATE NOT NULL,
    effective_to DATE,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_dim_customer_city
        FOREIGN KEY (city_key) REFERENCES analytics.dim_city(city_key),
    CONSTRAINT chk_dim_customer_dates
        CHECK (effective_to IS NULL OR effective_to >= effective_from)
);

CREATE TABLE analytics.dim_product (
    product_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT NOT NULL,
    sku VARCHAR(100) NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    category_key BIGINT NOT NULL,
    supplier_key BIGINT NOT NULL,
    product_status VARCHAR(30) NOT NULL,
    effective_from DATE NOT NULL,
    effective_to DATE,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_dim_product_category
        FOREIGN KEY (category_key) REFERENCES analytics.dim_category(category_key),
    CONSTRAINT fk_dim_product_supplier
        FOREIGN KEY (supplier_key) REFERENCES analytics.dim_supplier(supplier_key),
    CONSTRAINT chk_dim_product_dates
        CHECK (effective_to IS NULL OR effective_to >= effective_from)
);