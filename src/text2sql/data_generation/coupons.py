from faker import Faker
import numpy as np

from .common import random_date


fake = Faker()
Faker.seed(42)
np.random.seed(42)


COUPON_COUNT = 5_000


def generate_coupons():

    for coupon_id in range(1, COUPON_COUNT + 1):

        discount_type = fake.random_element(
            elements=[
                "percentage",
                "fixed",
            ]
        )

        if discount_type == "percentage":
            discount_value = round(
                float(np.random.uniform(5, 40)),
                2,
            )
        else:
            discount_value = round(
                float(np.random.uniform(5, 100)),
                2,
            )

        yield {
            "coupon_id": coupon_id,
            "coupon_code": f"OMNI-{coupon_id:05d}",
            "discount_type": discount_type,
            "discount_value": discount_value,
            "valid_from": random_date(2024, 2026).date(),
            "valid_to": random_date(2026, 2027).date(),
            "usage_limit": int(
                np.random.randint(100, 10_000)
            ),
        }