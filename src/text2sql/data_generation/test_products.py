from products import generate_products


categories = [1, 2, 3, 4, 5]
suppliers = [1, 2, 3, 4, 5]


products = generate_products(
    categories=categories,
    suppliers=suppliers,
)

print(f"Generated products: {len(products)}")
print(products[:3])