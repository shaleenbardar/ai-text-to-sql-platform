from customers import generate_customers
city_ids = [1, 2, 3, 4, 5]

customers = generate_customers(city_ids)

print(f"Generated customers: {len(customers)}")
print(customers[:3])