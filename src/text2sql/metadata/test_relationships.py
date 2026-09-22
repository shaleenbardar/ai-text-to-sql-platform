from relationships import discover_relationships


relationships = discover_relationships()

for relationship in relationships:
    print(
        f"{relationship['source_table']}"
        f".{relationship['source_columns']}"
        f" -> "
        f"{relationship['target_table']}"
        f".{relationship['target_columns']}"
    )