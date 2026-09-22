BUSINESS_METADATA = {
    "revenue": {
        "description": (
            "Revenue is the value of successfully completed or paid "
            "orders, excluding cancelled orders."
        ),
        "primary_table": "fact_orders",
        "measure": "total_amount",
        "filter": "order_status IN ('completed', 'paid')",
    },

    "orders": {
        "description": (
            "An order represents a purchase transaction placed by a customer."
        ),
        "primary_table": "fact_orders",
        "count_column": "order_count",
    },

    "average_order_value": {
        "description": (
            "Average order value is total order revenue divided by "
            "the number of orders."
        ),
        "primary_table": "fact_orders",
        "formula": "SUM(total_amount) / SUM(order_count)",
    },

    "units_sold": {
        "description": (
            "Total number of product units sold through order line items."
        ),
        "primary_table": "fact_order_items",
        "measure": "quantity",
    },

    "product_revenue": {
        "description": (
            "Revenue generated from individual product line items."
        ),
        "primary_table": "fact_order_items",
        "measure": "line_total",
    },

    "inventory_available": {
        "description": (
            "Inventory currently available for sale after subtracting "
            "reserved inventory from inventory on hand."
        ),
        "primary_table": "fact_inventory",
        "measure": "available_quantity",
    },

    "customer": {
        "description": (
            "A registered customer who can place orders and interact "
            "with products."
        ),
        "primary_table": "dim_customer",
    },

    "product": {
        "description": (
            "A product sold through the OmniCart marketplace."
        ),
        "primary_table": "dim_product",
    },

    "cancelled_order": {
        "description": (
            "An order whose lifecycle status is cancelled. Cancelled "
            "orders should not be included in revenue calculations."
        ),
        "primary_table": "fact_orders",
        "filter": "order_status = 'cancelled'",
    },
}


def get_business_metadata(term):
    return BUSINESS_METADATA.get(term)