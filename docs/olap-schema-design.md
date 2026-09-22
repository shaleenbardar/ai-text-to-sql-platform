# OLAP Star Schema Design

## Purpose

The OLAP model provides an analytical representation of the OmniCart ecommerce business.

The OLTP schema is optimized for transactional consistency and normalized storage, while the OLAP schema is designed for analytical queries, aggregation, reporting, and Text-to-SQL workloads.

The OLAP model follows a star-schema approach using fact and dimension tables.

## OLTP vs OLAP

| Characteristic | OLTP | OLAP |
|---|---|---|
| Primary purpose | Transactions | Analytics |
| Data model | Normalized | Dimensional |
| Main operations | INSERT / UPDATE / DELETE | SELECT / aggregation |
| Typical queries | Order/payment operations | Revenue, trends, KPIs |
| Optimization | Transaction processing | Analytical workloads |
| Example | `orders` | `fact_order_items` |

## Fact vs Dimension Tables

### Fact Tables

Fact tables contain measurable business events or states.

Planned fact tables:

- fact_order_items
- fact_payments
- fact_inventory
- fact_returns

### Dimension Tables

Dimension tables provide descriptive context for facts.

Planned dimensions:

- dim_date
- dim_customer
- dim_product
- dim_category
- dim_supplier
- dim_city
- dim_warehouse

## Grain Definitions

### fact_order_items

One row represents one product line within one customer order.

### fact_payments

One row represents one payment transaction or payment attempt.

### fact_inventory

One row represents the inventory state of one product at one warehouse for a specific snapshot date.

### fact_returns

One row represents one return transaction associated with an order item.

## Dimension Tables

### dim_date

Purpose: Provides calendar attributes for analytical time-based reporting.

Planned attributes:

- date_key
- full_date
- day
- month
- month_name
- quarter
- year
- week
- day_of_week
- day_name

### dim_customer

Purpose: Provides customer attributes used for segmentation and customer analytics.

Planned attributes:

- customer_key
- customer_id
- first_name
- last_name
- email
- city_key
- customer_status
- effective_from
- effective_to
- is_current

### dim_product

Purpose: Provides descriptive product information.

Planned attributes:

- product_key
- product_id
- sku
- product_name
- category_key
- supplier_key
- product_status
- effective_from
- effective_to
- is_current

### dim_category

Purpose: Provides product category information.

Planned attributes:

- category_key
- category_id
- category_name
- description

### dim_supplier

Purpose: Provides supplier information.

Planned attributes:

- supplier_key
- supplier_id
- supplier_name
- city_key
- supplier_status

### dim_city

Purpose: Provides geographic information.

Planned attributes:

- city_key
- city_id
- city_name
- country_id
- country_code
- country_name

### dim_warehouse

Purpose: Provides warehouse and fulfillment location information.

Planned attributes:

- warehouse_key
- warehouse_id
- warehouse_code
- warehouse_name
- city_key
- warehouse_status

## Fact Tables

### fact_order_items

Grain: One row per product line within an order.

Measures:

- quantity
- unit_price
- discount_amount
- line_total

Foreign keys:

- date_key
- customer_key
- product_key
- category_key
- supplier_key
- city_key

Degenerate/reference identifiers:

- order_id
- order_item_id

### fact_payments

Grain: One row per payment transaction or payment attempt.

Measures:

- payment_amount

Foreign keys:

- date_key
- customer_key

Reference identifiers:

- payment_id
- order_id

### fact_inventory

Grain: One row per product, warehouse, and snapshot date.

Measures:

- quantity_on_hand
- quantity_reserved
- available_quantity

Foreign keys:

- date_key
- product_key
- warehouse_key

### fact_returns

Grain: One row per return transaction.

Measures:

- return_quantity
- refund_amount

Foreign keys:

- date_key
- customer_key
- product_key

Reference identifiers:

- return_id
- order_item_id

## Star Schema Relationships

The primary sales star is centered on `fact_order_items`.

It connects to:

- dim_date
- dim_customer
- dim_product
- dim_category
- dim_supplier
- dim_city

Inventory connects:

- fact_inventory
- dim_date
- dim_product
- dim_warehouse

Payments connect:

- fact_payments
- dim_date
- dim_customer

Returns connect:

- fact_returns
- dim_date
- dim_customer
- dim_product

## Slowly Changing Dimensions

The design supports Slowly Changing Dimension Type 2 for dimensions where historical attribute changes are analytically important.

Type 2 tracking uses:

- effective_from
- effective_to
- is_current

This allows historical analysis to preserve the dimensional context associated with a business event.

## Surrogate Keys

Dimensions use warehouse-generated surrogate keys.

For example:

- customer_key
- product_key
- category_key
- supplier_key
- city_key
- warehouse_key

Source-system identifiers such as customer_id and product_id are retained as business/source identifiers.

## Analytical Use Cases

The OLAP model is designed to support:

- Revenue by day, month, quarter, and year
- Revenue by product
- Revenue by category
- Revenue by supplier
- Revenue by customer
- Revenue by geography
- Customer purchasing analysis
- Product performance analysis
- Inventory analysis
- Warehouse analysis
- Payment analysis
- Return analysis
- Product return-rate analysis
- Time-series analysis