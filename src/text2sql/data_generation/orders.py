from faker import Faker
import numpy as np

from .common import random_date


fake = Faker()
Faker.seed(42)
np.random.seed(42)


ORDER_COUNT = 2_000_000


def generate_orders(
    customer_ids,
    coupon_ids=None,
    batch_size=10_000,
):
    """
    Generate orders in batches.

    Yields lists instead of keeping 2M rows in memory.
    """

    coupon_ids = coupon_ids or []

    for start in range(1, ORDER_COUNT + 1, batch_size):
        end = min(start + batch_size, ORDER_COUNT + 1)

        batch = []

        for order_id in range(start, end):
            customer_id = fake.random_element(
                elements=customer_ids
            )

            subtotal = round(
                float(np.random.lognormal(4.2, 0.8)),
                2,
            )

            discount_amount = round(
                subtotal * np.random.uniform(0, 0.20),
                2,
            )

            tax_amount = round(
                (subtotal - discount_amount)
                * np.random.uniform(0.05, 0.18),
                2,
            )

            shipping_amount = round(
                np.random.uniform(0, 50),
                2,
            )

            total_amount = round(
                subtotal
                - discount_amount
                + tax_amount
                + shipping_amount,
                2,
            )

            order_status = fake.random_element(
                elements=[
                    "completed",
                    "paid",
                    "processing",
                    "shipped",
                    "cancelled",
                ]
            )

            coupon_id = (
                fake.random_element(elements=coupon_ids)
                if coupon_ids and np.random.random() < 0.25
                else None
            )

            batch.append(
                {
                    "order_id": order_id,
                    "customer_id": customer_id,
                    "order_date": random_date(),
                    "order_status": order_status,
                    "subtotal": subtotal,
                    "discount_amount": discount_amount,
                    "tax_amount": tax_amount,
                    "shipping_amount": shipping_amount,
                    "total_amount": total_amount,
                    "coupon_id": coupon_id,
                }
            )

        yield batch