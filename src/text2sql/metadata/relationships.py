from sqlalchemy import inspect

from database import engine


def discover_relationships(schema="public"):
    inspector = inspect(engine)

    relationships = []

    for table_name in inspector.get_table_names(
        schema=schema
    ):
        foreign_keys = inspector.get_foreign_keys(
            table_name,
            schema=schema,
        )

        for fk in foreign_keys:
            relationships.append(
                {
                    "schema": schema,
                    "source_table": table_name,
                    "source_columns": fk["constrained_columns"],
                    "target_table": fk["referred_table"],
                    "target_columns": fk["referred_columns"],
                    "constraint_name": fk["name"],
                }
            )

    return relationships