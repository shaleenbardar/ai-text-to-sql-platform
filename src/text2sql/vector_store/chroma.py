from pathlib import Path

import chromadb


CHROMA_PATH = Path("data/chroma")


client = chromadb.PersistentClient(
    path=str(CHROMA_PATH)
)


def get_collection(
    name="metadata",
):
    return client.get_or_create_collection(
        name=name,
    )