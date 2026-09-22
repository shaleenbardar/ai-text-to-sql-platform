from faker import Faker
import numpy as np


fake = Faker()
Faker.seed(42)
np.random.seed(42)


PRODUCT_COUNT = 10_000


def generate_products(categories, suppliers):
    """
    Generate synthetic product records.

    Parameters
    ----------
    categories:
        List of existing category IDs.

    suppliers:
        List of existing supplier IDs.
    """

    products = []

    for product_id in range(1, PRODUCT_COUNT + 1):
        category_id = fake.random_element(elements=categories)
        supplier_id = fake.random_element(elements=suppliers)

        product_name = (
            f"{fake.word().title()} "
            f"{fake.word().title()} "
            f"{fake.word().title()}"
        )

        sku = f"SKU-{product_id:06d}"

        unit_price = round(
            float(np.random.lognormal(mean=3.5, sigma=1.0)),
            2
        )

        product_status = fake.random_element(
            elements=[
                "active",
                "inactive",
                "discontinued"
            ]
        )

        products.append(
            {
                "product_id": product_id,
                "sku": sku,
                "product_name": product_name,
                "category_id": category_id,
                "supplier_id": supplier_id,
                "unit_price": unit_price,
                "product_status": product_status,
            }
        )

    return products