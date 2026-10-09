from text2sql.embeddings.local_embeddings import create_embedding
from text2sql.vector_store.chroma import get_collection


def search_metadata(
    query: str,
    top_k: int = 5,
):
    """
    Find the most semantically relevant metadata
    for a natural-language query.
    """

    query_embedding = create_embedding(query)

    collection = get_collection()

    results = collection.query(
        query_embeddings=[query_embedding],
        n_results=top_k,
    )

    return results