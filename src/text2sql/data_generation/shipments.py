from faker import Faker
import numpy as np

from .common import random_date


fake = Faker()
Faker.seed(42)
np.random.seed(42)


def generate_shipments(
    orders,
    warehouse_ids,
):
    for order in orders:

        shipment_status = fake.random_element(
            elements=[
                "pending",
                "shipped",
                "in_transit",
                "delivered",
                "returned",
            ]
        )

        shipped_at = None
        delivered_at = None

        if shipment_status != "pending":
            shipped_at = order["order_date"]

        if shipment_status == "delivered":
            delivered_at = shipped_at

        yield {
            "order_id": order["order_id"],
            "warehouse_id": fake.random_element(
                elements=warehouse_ids
            ),
            "carrier": fake.random_element(
                elements=[
                    "FedEx",
                    "UPS",
                    "DHL",
                    "USPS",
                    "BlueDart",
                ]
            ),
            "tracking_number": fake.bothify(
                text="TRK-##########"
            ),
            "shipment_status": shipment_status,
            "shipped_at": shipped_at,
            "delivered_at": delivered_at,
        }