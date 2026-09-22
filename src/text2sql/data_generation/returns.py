from faker import Faker
import numpy as np


fake = Faker()
Faker.seed(42)
np.random.seed(42)


def generate_returns(
    order_items,
    return_probability=0.08,
    batch_size=10_000,
):
    rows = []
    return_id = 1

    for item in order_items:

        if np.random.random() > return_probability:
            continue

        quantity = int(
            np.random.randint(
                1,
                item["quantity"] + 1,
            )
        )

        refund_amount = round(
            item["unit_price"] * quantity,
            2,
        )

        rows.append(
            {
                "return_id": return_id,
                "order_item_id": item["order_item_id"],
                "return_quantity": quantity,
                "refund_amount": refund_amount,
                "return_status": fake.random_element(
                    elements=[
                        "requested",
                        "approved",
                        "processed",
                        "rejected",
                    ]
                ),
            }
        )

        return_id += 1

        if len(rows) >= batch_size:
            yield rows
            rows = []

    if rows:
        yield rows