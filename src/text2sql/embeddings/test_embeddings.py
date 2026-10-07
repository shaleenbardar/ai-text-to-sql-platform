from text2sql.embeddings.local_embeddings import (
    create_embedding,
    create_embeddings,
)


text = """
orders.total_amount represents the final amount
charged for an order after discounts, tax,
and shipping.
"""

embedding = create_embedding(text)

print("Single embedding created")
print("Vector dimensions:", len(embedding))


texts = [
    "orders.total_amount: Final amount charged for an order.",
    "products.unit_price: Selling price of one product.",
    "customers.customer_id: Unique identifier for a customer.",
]

embeddings = create_embeddings(texts)

print("Batch embeddings created")
print("Number of vectors:", len(embeddings))
print("Vector dimensions:", len(embeddings[0]))