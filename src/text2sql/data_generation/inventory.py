import numpy as np


def generate_inventory(
    product_ids,
    warehouse_ids,
    batch_size=10_000,
):
    rows = []
    count = 0

    for warehouse_id in warehouse_ids:
        for product_id in product_ids:

            quantity_on_hand = int(
                np.random.randint(0, 1000)
            )

            quantity_reserved = int(
                np.random.randint(
                    0,
                    quantity_on_hand + 1,
                )
            )

            rows.append(
                {
                    "warehouse_id": warehouse_id,
                    "product_id": product_id,
                    "quantity_on_hand": quantity_on_hand,
                    "quantity_reserved": quantity_reserved,
                }
            )

            count += 1

            if count >= batch_size:
                yield rows
                rows = []
                count = 0

    if rows:
        yield rows