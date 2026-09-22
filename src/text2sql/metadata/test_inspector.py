from inspector import (
    get_tables,
    get_columns,
    get_primary_keys,
    get_foreign_keys,
)


tables = get_tables()

print("Tables:")
for table in tables:
    print(f" - {table}")


print("\nCustomers columns:")
for column in get_columns("customers"):
    print(
        column["name"],
        column["type"],
        "nullable=",
        column["nullable"],
    )


print("\nCustomers primary key:")
print(get_primary_keys("customers"))


print("\nCustomers foreign keys:")
print(get_foreign_keys("customers"))