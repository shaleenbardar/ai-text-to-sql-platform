# OLTP Schema Design

## Purpose

## Design Principles

## Entity Overview

## Entity Relationships

## Table Definitions
### countries

**Purpose:** Stores countries in which OmniCart operates.

| Column | Type | Constraints | Description |
|---|---|---|---|
| country_id | INTEGER | PK | Unique country identifier |
| country_code | CHAR(2) | UNIQUE, NOT NULL | Two-letter country code |
| country_name | VARCHAR(100) | NOT NULL | Country name |
| created_at | TIMESTAMP | NOT NULL | Record creation timestamp |

### cities

**Purpose:** Stores cities associated with countries.

| Column | Type | Constraints | Description |
|---|---|---|---|
| city_id | INTEGER | PK | Unique city identifier |
| country_id | INTEGER | FK, NOT NULL | References countries |
| city_name | VARCHAR(100) | NOT NULL | City name |
| postal_code | VARCHAR(20) | | Postal/ZIP code |
| created_at | TIMESTAMP | NOT NULL | Record creation timestamp |

### customers

**Purpose:** Stores OmniCart customer accounts.

| Column | Type | Constraints | Description |
|---|---|---|---|
| customer_id | BIGINT | PK | Unique customer identifier |
| city_id | INTEGER | FK, NOT NULL | References cities |
| first_name | VARCHAR(100) | NOT NULL | Customer first name |
| last_name | VARCHAR(100) | NOT NULL | Customer last name |
| email | VARCHAR(255) | UNIQUE, NOT NULL | Customer email |
| phone | VARCHAR(30) | | Customer phone number |
| date_of_birth | DATE | | Customer date of birth |
| customer_status | VARCHAR(20) | NOT NULL | Customer account status |
| created_at | TIMESTAMP | NOT NULL | Account creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

### categories

**Purpose:** Stores product categories available on the OmniCart platform.

| Column | Type | Constraints | Description |
|---|---|---|---|
| category_id | INTEGER | PK | Unique category identifier |
| category_name | VARCHAR(100) | UNIQUE, NOT NULL | Category name |
| description | TEXT | | Category description |
| created_at | TIMESTAMP | NOT NULL | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

### suppliers

**Purpose:** Stores suppliers that provide products to OmniCart.

| Column | Type | Constraints | Description |
|---|---|---|---|
| supplier_id | INTEGER | PK | Unique supplier identifier |
| supplier_name | VARCHAR(200) | NOT NULL | Supplier/company name |
| contact_name | VARCHAR(150) | | Primary contact |
| email | VARCHAR(255) | | Supplier email |
| phone | VARCHAR(30) | | Supplier phone |
| city_id | INTEGER | FK | References cities |
| supplier_status | VARCHAR(20) | NOT NULL | Supplier status |
| created_at | TIMESTAMP | NOT NULL | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

### products

**Purpose:** Stores products sold through the OmniCart platform.

| Column | Type | Constraints | Description |
|---|---|---|---|
| product_id | BIGINT | PK | Unique product identifier |
| category_id | INTEGER | FK, NOT NULL | References categories |
| supplier_id | INTEGER | FK, NOT NULL | References suppliers |
| product_name | VARCHAR(255) | NOT NULL | Product name |
| sku | VARCHAR(50) | UNIQUE, NOT NULL | Stock keeping unit |
| description | TEXT | | Product description |
| unit_price | NUMERIC(12,2) | NOT NULL | Current selling price |
| product_status | VARCHAR(20) | NOT NULL | Product status |
| created_at | TIMESTAMP | NOT NULL | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

### orders

**Purpose:** Represents customer orders and preserves the financial values associated with each transaction.
One coupon can be associated with many orders.
An order can have zero or one coupon.

| Column | Type | Constraints | Description |
|---|---|---|---|
| order_id | BIGINT | PK | Unique order identifier |
| customer_id | BIGINT | FK, NOT NULL | References customers |
| order_date | TIMESTAMP | NOT NULL | Order creation date/time |
| order_status | VARCHAR(30) | NOT NULL | Current order status |
| subtotal | NUMERIC(14,2) | NOT NULL | Sum of order item values |
| discount_amount | NUMERIC(14,2) | NOT NULL | Total discount applied |
| tax_amount | NUMERIC(14,2) | NOT NULL | Tax charged |
| coupon_id | INTEGER | FK | Applied coupon; nullable
| shipping_amount | NUMERIC(14,2) | NOT NULL | Shipping charge |
| total_amount | NUMERIC(14,2) | NOT NULL | Final order amount |
| created_at | TIMESTAMP | NOT NULL | Record creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

**Order status lifecycle:**

PENDING → CONFIRMED → PROCESSING → SHIPPED → DELIVERED

Orders may also be cancelled before completion.

### order_items

**Purpose:** Represents individual products purchased within an order.

| Column | Type | Constraints | Description |
|---|---|---|---|
| order_item_id | BIGINT | PK | Unique order-item identifier |
| order_id | BIGINT | FK, NOT NULL | References orders |
| product_id | BIGINT | FK, NOT NULL | References products |
| quantity | INTEGER | NOT NULL | Number of units purchased |
| unit_price | NUMERIC(12,2) | NOT NULL | Product price at time of purchase |
| discount_amount | NUMERIC(12,2) | NOT NULL | Discount applied to line |
| line_total | NUMERIC(14,2) | NOT NULL | Final line-item amount |
| created_at | TIMESTAMP | NOT NULL | Record creation timestamp |

### payments

**Purpose:** Records payment attempts and payment transactions associated with orders.

| Column | Type | Constraints | Description |
|---|---|---|---|
| payment_id | BIGINT | PK | Unique payment identifier |
| order_id | BIGINT | FK, NOT NULL | References orders |
| payment_method | VARCHAR(30) | NOT NULL | Payment method |
| payment_status | VARCHAR(30) | NOT NULL | Payment status |
| amount | NUMERIC(14,2) | NOT NULL | Payment amount |
| transaction_reference | VARCHAR(100) | UNIQUE | External transaction reference |
| payment_date | TIMESTAMP | | Payment timestamp |
| created_at | TIMESTAMP | NOT NULL | Record creation timestamp |

### shipments

**Purpose:** Tracks order fulfillment and delivery.

| Column | Type | Constraints | Description |
|---|---|---|---|
| shipment_id | BIGINT | PK | Unique shipment identifier |
| order_id | BIGINT | FK, UNIQUE, NOT NULL | References orders |
| warehouse_id | INTEGER | FK, NOT NULL | Fulfillment warehouse |
| carrier_name | VARCHAR(100) | | Shipping carrier |
| tracking_number | VARCHAR(100) | UNIQUE | Tracking number |
| shipment_status | VARCHAR(30) | NOT NULL | Shipment status |
| shipped_at | TIMESTAMP | | Shipment timestamp |
| delivered_at | TIMESTAMP | | Delivery timestamp |
| created_at | TIMESTAMP | NOT NULL | Record creation timestamp |

### returns

**Purpose:** Records products returned by customers.

Returns reference order items because customers can return individual products from an order.

| Column | Type | Constraints | Description |
|---|---|---|---|
| return_id | BIGINT | PK | Unique return identifier |
| order_item_id | BIGINT | FK, NOT NULL | References order_items |
| return_quantity | INTEGER | NOT NULL | Quantity returned |
| return_reason | VARCHAR(255) | | Reason for return |
| return_status | VARCHAR(30) | NOT NULL | Return status |
| refund_amount | NUMERIC(14,2) | NOT NULL | Refund amount |
| requested_at | TIMESTAMP | NOT NULL | Return request timestamp |
| processed_at | TIMESTAMP | | Processing timestamp |
| created_at | TIMESTAMP | NOT NULL | Record creation timestamp |

### coupons

**Purpose:** Stores promotional coupons that can be applied to orders.

| Column | Type | Constraints | Description |
|---|---|---|---|
| coupon_id | INTEGER | PK | Unique coupon identifier |
| coupon_code | VARCHAR(50) | UNIQUE, NOT NULL | Coupon code |
| discount_type | VARCHAR(20) | NOT NULL | Percentage or fixed amount |
| discount_value | NUMERIC(12,2) | NOT NULL | Discount value |
| minimum_order_amount | NUMERIC(14,2) | | Minimum qualifying order |
| maximum_discount_amount | NUMERIC(14,2) | | Maximum discount cap |
| valid_from | TIMESTAMP | NOT NULL | Coupon start date |
| valid_until | TIMESTAMP | NOT NULL | Coupon expiration date |
| coupon_status | VARCHAR(20) | NOT NULL | Coupon status |
| created_at | TIMESTAMP | NOT NULL | Creation timestamp |

### warehouses

**Purpose:** Stores physical warehouse locations used for inventory fulfillment.

| Column | Type | Constraints | Description |
|---|---|---|---|
| warehouse_id | INTEGER | PK | Unique warehouse identifier |
| city_id | INTEGER | FK, NOT NULL | References cities |
| warehouse_name | VARCHAR(150) | NOT NULL | Warehouse name |
| warehouse_code | VARCHAR(30) | UNIQUE, NOT NULL | Business warehouse code |
| warehouse_status | VARCHAR(20) | NOT NULL | Warehouse status |
| created_at | TIMESTAMP | NOT NULL | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

### inventory

**Purpose:** Tracks product inventory across warehouses.

| Column | Type | Constraints | Description |
|---|---|---|---|
| inventory_id | BIGINT | PK | Unique inventory record |
| warehouse_id | INTEGER | FK, NOT NULL | References warehouses |
| product_id | BIGINT | FK, NOT NULL | References products |
| quantity_on_hand | INTEGER | NOT NULL | Physical inventory |
| quantity_reserved | INTEGER | NOT NULL | Inventory reserved for orders |
| reorder_level | INTEGER | NOT NULL | Inventory reorder threshold |
| last_restocked_at | TIMESTAMP | | Last restock timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

**Constraints:**

- `UNIQUE (warehouse_id, product_id)`
- `quantity_on_hand >= 0`
- `quantity_reserved >= 0`
- `reorder_level >= 0`

### reviews

**Purpose:** Stores customer reviews and ratings for products.

| Column | Type | Constraints | Description |
|---|---|---|---|
| review_id | BIGINT | PK | Unique review identifier |
| customer_id | BIGINT | FK, NOT NULL | References customers |
| product_id | BIGINT | FK, NOT NULL | References products |
| rating | SMALLINT | NOT NULL | Rating from 1 to 5 |
| review_title | VARCHAR(255) | | Review title |
| review_text | TEXT | | Review content |
| review_status | VARCHAR(20) | NOT NULL | Review moderation status |
| review_date | TIMESTAMP | NOT NULL | Review timestamp |
| created_at | TIMESTAMP | NOT NULL | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL | Last update timestamp |

**Constraints:**

- `CHECK (rating BETWEEN 1 AND 5)`
- `UNIQUE (customer_id, product_id)`

## Relationship Summary
- One country has many cities.
- One city has many customers.
- One city can contain many warehouses.
- One category has many products.
- One supplier supplies many products.
- One customer has many orders.
- One order has many order items.
- One product can appear in many order items.
- One order can have many payment attempts.
- One order has at most one shipment.
- One order item can have multiple return records.
- One coupon can be applied to many orders.
- One warehouse stores many products.
- One product can exist in many warehouses.
- One customer can write many reviews.
- One product can have many reviews.

## Normalization Strategy