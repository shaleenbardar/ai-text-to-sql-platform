from .chroma import get_collection


collection = get_collection()


collection.upsert(
    ids=[
        "orders_total_amount",
        "products_unit_price",
        "customers_customer_id",
    ],
    documents=[
        (
            "orders.total_amount: "
            "Final order amount after discounts, "
            "tax, and shipping."
        ),
        (
            "products.unit_price: "
            "Selling price of one unit of the product."
        ),
        (
            "customers.customer_id: "
            "Unique identifier for the customer."
        ),
    ],
)


print(
    "Documents stored:",
    collection.count(),
)