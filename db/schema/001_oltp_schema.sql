-- ============================================================
-- OmniCart OLTP Schema
-- ============================================================
-- Purpose:
--     Transactional database schema for the OmniCart ecommerce
--     analytics platform.
--
-- This file contains the initial relational schema.
-- ============================================================


-- ============================================================
-- Countries
-- ============================================================

CREATE TABLE countries (
    country_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    country_code CHAR(2) NOT NULL UNIQUE,
    country_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- Cities
-- ============================================================

CREATE TABLE cities (
    city_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    country_id INTEGER NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_cities_country
        FOREIGN KEY (country_id)
        REFERENCES countries(country_id)
);


-- ============================================================
-- Customers
-- ============================================================

CREATE TABLE customers (
    customer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    city_id INTEGER NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(30),
    date_of_birth DATE,
    customer_status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_customers_city
        FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
);