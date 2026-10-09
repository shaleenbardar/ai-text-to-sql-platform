from text2sql.embeddings.schema_embeddings import (
    create_schema_embeddings,
)
from text2sql.vector_store.chroma import get_collection


def index_metadata():
    """
    Generate embeddings for schema/business metadata
    and store them in ChromaDB.
    """

    ids, documents, embeddings = create_schema_embeddings()

    collection = get_collection()

    collection.upsert(
        ids=ids,
        documents=documents,
        embeddings=embeddings,
    )

    return collection.count()


if __name__ == "__main__":
    count = index_metadata()

    print(f"Metadata documents indexed: {count}")