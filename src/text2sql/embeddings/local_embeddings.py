from sentence_transformers import SentenceTransformer


EMBEDDING_MODEL = "all-MiniLM-L6-v2"

model = SentenceTransformer(EMBEDDING_MODEL)


def create_embedding(text: str) -> list[float]:
    """
    Convert a single text string into a semantic embedding vector.
    """
    embedding = model.encode(
        text,
        normalize_embeddings=True,
    )

    return embedding.tolist()


def create_embeddings(texts: list[str]) -> list[list[float]]:
    """
    Convert multiple text strings into semantic embedding vectors.
    """
    embeddings = model.encode(
        texts,
        normalize_embeddings=True,
    )

    return embeddings.tolist()