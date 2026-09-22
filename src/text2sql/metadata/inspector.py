from sqlalchemy import inspect

from database import engine


def get_database_inspector():
    return inspect(engine)


def get_tables(schema="public"):
    inspector = get_database_inspector()

    return inspector.get_table_names(
        schema=schema
    )


def get_columns(table_name, schema="public"):
    inspector = get_database_inspector()

    return inspector.get_columns(
        table_name,
        schema=schema,
    )


def get_primary_keys(table_name, schema="public"):
    inspector = get_database_inspector()

    return inspector.get_pk_constraint(
        table_name,
        schema=schema,
    )


def get_foreign_keys(table_name, schema="public"):
    inspector = get_database_inspector()

    return inspector.get_foreign_keys(
        table_name,
        schema=schema,
    )