from faker import Faker
import numpy as np


fake = Faker()
Faker.seed(42)
np.random.seed(42)


def generate_reviews(
    customer_ids,
    product_ids,
    review_count=1_000_000,
    batch_size=10_000,
):
    rows = []

    for review_id in range(1, review_count + 1):

        rows.append(
            {
                "review_id": review_id,
                "customer_id": fake.random_element(
                    elements=customer_ids
                ),
                "product_id": fake.random_element(
                    elements=product_ids
                ),
                "rating": int(
                    np.random.randint(1, 6)
                ),
                "review_text": fake.paragraph(
                    nb_sentences=3
                ),
                "review_date": fake.date_between(
                    start_date="-2y",
                    end_date="today",
                ),
            }
        )

        if len(rows) >= batch_size:
            yield rows
            rows = []

    if rows:
        yield rows