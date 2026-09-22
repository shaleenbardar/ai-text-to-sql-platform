1. Our fictional company

Let's establish:

Company: OmniCart
Industry: E-commerce
Business model: Online retail marketplace
Geography: Multiple countries and cities
Customers: Individual consumers
Products: Multiple categories and suppliers
Orders: Customers purchase one or more products
Operations: Inventory, payments, shipments, returns and reviews


2. What should our AI Data Analyst answer?

We'll design around several business areas.

Sales & Revenue

Examples:

What was total revenue last quarter?

Which products generated the most revenue?

What are our monthly sales trends?

Which categories contribute the most revenue?

What is the average order value?
Customer Analytics
How many active customers do we have?

Which countries have the most customers?

Who are our highest-value customers?

What is the average spend per customer?

How many new customers did we acquire each month?
Product Analytics
Which products sell the most?

Which categories have the highest revenue?

Which products have the lowest ratings?

Which suppliers provide the most products?
Operations
Which products are low in inventory?

What is our current inventory value?

What percentage of orders have been shipped?

What is the average shipping time?

Which warehouses have the most inventory?

Payments
What percentage of orders have been paid?

What is the total value of successful payments?

Which payment methods are most popular?
Returns & Reviews
What is our return rate?

Which products have the highest return rate?

Which products have the best customer ratings?

How does rating vary by category?



3. Business entities

From those questions, we can identify the major entities:

Customer
    │
    └── Order
          │
          └── Order Item
                 │
                 └── Product
                       │
                       ├── Category
                       └── Supplier

And around the order lifecycle:

Order
 ├── Payment
 ├── Shipment
 ├── Return
 └── Review

And inventory:

Product
   │
   ▼
Inventory
   │
   ▼
Warehouse / Store

And geography:

Country
   │
   ▼
City
   │
   ▼
Customer

This gives us the conceptual foundation for DB-002: OLTP schema design.

4. Business rules

We also need rules that our future AI must understand.

For example:

Revenue

We'll eventually define exactly what "revenue" means.

A useful initial business definition:

Revenue = value of successfully completed/paid orders, excluding cancelled orders.

This is important because if someone asks:

"What was our revenue?"

the LLM shouldn't randomly choose SUM(order_total) without understanding the business definition.

Our project specifically calls for a Business Glossary later, with definitions such as revenue and sales rules retrieved before SQL generation.

Customer

"Customer" means a registered customer in our customer entity.

Sales

"Sales" should represent qualifying orders according to our business rules rather than every order record.

Order

An order can contain multiple products.

Therefore:

Order
   ↓
Order Items
   ↓
Products

This distinction will become very important when we start writing SQL.

5. Scale target

Our original project design targets approximately:

Entity	Target
Customers	500,000
Orders	2,000,000
Products	10,000
Warehouses	100
Cities	100
Categories