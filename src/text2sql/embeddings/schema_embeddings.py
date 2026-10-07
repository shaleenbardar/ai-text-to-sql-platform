from text2sql.embeddings.local_embeddings import create_embeddings
from text2sql.metadata.business_glossary import get_all_glossary_terms
from text2sql.metadata.descriptions import COLUMN_DESCRIPTIONS


def build_column_documents():
    """
    Convert column descriptions into searchable documents.
    """
    documents = []
    ids = []

    for table_name, columns in COLUMN_DESCRIPTIONS.items():
        for column_name, description in columns.items():
            document_id = f"{table_name}_{column_name}"

            document = (
                f"Table: {table_name}\n"
                f"Column: {column_name}\n"
                f"Description: {description}"
            )

            ids.append(document_id)
            documents.append(document)

    return ids, documents


def build_glossary_documents():
    """
    Convert business glossary terms into searchable documents.
    """
    documents = []
    ids = []

    glossary = get_all_glossary_terms()

    for key, metadata in glossary.items():
        document_id = f"glossary_{key}"

        document = (
            f"Business Term: {metadata['term']}\n"
            f"Definition: {metadata['definition']}\n"
            f"Synonyms: {', '.join(metadata['synonyms'])}\n"
            f"Related Tables: {', '.join(metadata['related_tables'])}\n"
            f"Related Columns: {', '.join(metadata['related_columns'])}\n"
            f"Business Rule: {metadata['business_rule']}"
        )

        ids.append(document_id)
        documents.append(document)

    return ids, documents


def build_schema_documents():
    """
    Build all searchable schema and business metadata documents.
    """
    column_ids, column_documents = build_column_documents()
    glossary_ids, glossary_documents = build_glossary_documents()

    return (
        column_ids + glossary_ids,
        column_documents + glossary_documents,
    )


def create_schema_embeddings():
    """
    Create embeddings for all schema and business metadata.
    """
    ids, documents = build_schema_documents()

    embeddings = create_embeddings(documents)

    return ids, documents, embeddings