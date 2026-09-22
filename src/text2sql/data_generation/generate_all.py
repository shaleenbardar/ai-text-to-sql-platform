from .coupons import generate_coupons
from .orders import generate_orders
from .inventory import generate_inventory
from .payments import generate_payments
from .shipments import generate_shipments
from .reviews import generate_reviews
from .returns import generate_returns


def main():
    print("Starting OmniCart data generation...")

    print("1. Generate coupons")
    coupons = list(generate_coupons())

    print(f"Generated {len(coupons)} coupons")

    print("2. Generate orders")
    print("3. Generate order items")
    print("4. Generate inventory")
    print("5. Generate payments")
    print("6. Generate shipments")
    print("7. Generate reviews")
    print("8. Generate returns")

    print("Data generation pipeline initialized.")


if __name__ == "__main__":
    main()