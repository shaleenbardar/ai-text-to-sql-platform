COLUMN_DESCRIPTIONS = {
    "customers": {
        "customer_id": "Unique identifier for the customer.",
        "first_name": "Customer's first name.",
        "last_name": "Customer's last name.",
        "email": "Customer email address.",
        "city_id": "City where the customer is located.",
        "customer_status": "Current status of the customer account.",
    },

    "products": {
        "product_id": "Unique identifier for the product.",
        "sku": "Unique stock keeping unit assigned to the product.",
        "product_name": "Name of the product.",
        "category_id": "Category assigned to the product.",
        "supplier_id": "Supplier responsible for the product.",
        "unit_price": "Selling price of one unit of the product.",
        "product_status": "Current status of the product.",
    },

    "orders": {
        "order_id": "Unique identifier for the order.",
        "customer_id": "Customer who placed the order.",
        "order_date": "Date and time when the order was placed.",
        "order_status": "Current lifecycle status of the order.",
        "subtotal": "Order value before discounts, tax, and shipping.",
        "discount_amount": "Discount applied to the order.",
        "tax_amount": "Tax charged on the order.",
        "shipping_amount": "Shipping charge for the order.",
        "total_amount": "Final order amount after discounts, tax, and shipping.",
        "coupon_id": "Coupon applied to the order, if any.",
    },

    "order_items": {
        "order_item_id": "Unique identifier for an order line item.",
        "order_id": "Order containing this line item.",
        "product_id": "Product included in this line item.",
        "quantity": "Number of product units purchased.",
        "unit_price": "Price of one product unit at the time of purchase.",
        "discount_amount": "Discount applied to this line item.",
        "line_total": "Final value of the line item after discount.",
    },

    "payments": {
        "payment_id": "Unique identifier for the payment transaction.",
        "order_id": "Order associated with the payment.",
        "payment_method": "Method used to make the payment.",
        "payment_status": "Status of the payment attempt.",
        "payment_amount": "Amount processed by the payment transaction.",
    },

    "inventory": {
        "warehouse_id": "Warehouse holding the inventory.",
        "product_id": "Product being tracked.",
        "quantity_on_hand": "Total physical units currently held.",
        "quantity_reserved": "Units reserved for existing orders.",
    },

    "reviews": {
        "review_id": "Unique identifier for the review.",
        "customer_id": "Customer who submitted the review.",
        "product_id": "Product being reviewed.",
        "rating": "Customer rating from 1 to 5.",
        "review_text": "Text written by the customer.",
        "review_date": "Date when the review was submitted.",
    },
}


def get_column_description(
    table_name,
    column_name,
):
    return COLUMN_DESCRIPTIONS.get(
        table_name,
        {},
    ).get(
        column_name,
        "No business description available.",
    )