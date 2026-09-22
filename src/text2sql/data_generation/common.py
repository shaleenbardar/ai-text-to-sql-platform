from datetime import datetime, timedelta
from faker import Faker
import numpy as np


fake = Faker()
Faker.seed(42)
np.random.seed(42)


BATCH_SIZE = 10_000


def random_date(start_year=2024, end_year=2026):
    start = datetime(start_year, 1, 1)
    end = datetime(end_year, 12, 31)

    days = (end - start).days

    return start + timedelta(
        days=int(np.random.randint(0, days + 1))
    )


def random_choice(values):
    return fake.random_element(elements=values)


def random_money(minimum=1, maximum=1000):
    return round(
        float(np.random.uniform(minimum, maximum)),
        2,
    )