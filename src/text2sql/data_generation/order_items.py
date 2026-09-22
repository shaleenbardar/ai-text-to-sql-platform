import numpy as np


def generate_order_items(
    orders,
    product_ids,
    product_prices,
    batch_size=10_000,
):
    rows = []
    order_item_id = 1

    for order in orders:

        item_count = int(
            np.random.randint(1, 6)
        )

        selected_products = np.random.choice(
            product_ids,
            size=item_count,
            replace=False,
        )

        for product_id in selected_products:

            unit_price = product_prices[product_id]

            quantity = int(
                np.random.randint(1, 5)
            )

            discount_amount = round(
                unit_price
                * quantity
                * np.random.uniform(0, 0.15),
                2,
            )

            line_total = round(
                unit_price * quantity
                - discount_amount,
                2,
            )

            rows.append(
                {
                    "order_item_id": order_item_id,
                    "order_id": order["order_id"],
                    "product_id": int(product_id),
                    "quantity": quantity,
                    "unit_price": unit_price,
                    "discount_amount": discount_amount,
                    "line_total": line_total,
                }
            )

            order_item_id += 1

            if len(rows) >= batch_size:
                yield rows
                rows = []

    if rows:
        yield rows