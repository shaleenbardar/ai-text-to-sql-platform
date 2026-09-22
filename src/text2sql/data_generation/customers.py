from faker import Faker
import numpy as np


fake = Faker()
Faker.seed(42)
np.random.seed(42)


CUSTOMER_COUNT = 100


def generate_customers(city_ids):
    """
    Generate synthetic customer records.

    city_ids:
        Existing city IDs from the database.
    """

    customers = []

    for customer_id in range(1, CUSTOMER_COUNT + 1):
        city_id = fake.random_element(elements=city_ids)

        customers.append(
            {
                "customer_id": customer_id,
                "first_name": fake.first_name(),
                "last_name": fake.last_name(),
                "email": f"customer{customer_id}@example.com",
                "city_id": city_id,
                "customer_status": fake.random_element(
                    elements=[
                        "active",
                        "inactive",
                        "suspended",
                    ]
                ),
            }
        )

    return customers