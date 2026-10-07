from fastapi import APIRouter

from text2sql.metadata.inspector import (
    get_tables,
    get_columns,
    get_primary_keys,
    get_foreign_keys,
)
from text2sql.metadata.relationships import (
    discover_relationships,
)
from text2sql.metadata.descriptions import (
    COLUMN_DESCRIPTIONS,
)
from text2sql.metadata.business_metadata import (
    BUSINESS_METADATA,
)


router = APIRouter(
    prefix="/metadata",
    tags=["Metadata"],
)


@router.get("/tables")
def list_tables(schema: str = "public"):
    return {
        "schema": schema,
        "tables": get_tables(schema),
    }


@router.get("/tables/{table_name}")
def get_table_metadata(
    table_name: str,
    schema: str = "public",
):
    return {
        "schema": schema,
        "table": table_name,
        "columns": get_columns(
            table_name,
            schema,
        ),
        "primary_key": get_primary_keys(
            table_name,
            schema,
        ),
        "foreign_keys": get_foreign_keys(
            table_name,
            schema,
        ),
    }


@router.get("/relationships")
def get_relationships(schema: str = "public"):
    return {
        "schema": schema,
        "relationships": discover_relationships(
            schema
        ),
    }


@router.get("/descriptions")
def get_descriptions():
    return COLUMN_DESCRIPTIONS


@router.get("/business")
def get_business_metadata():
    return BUSINESS_METADATA