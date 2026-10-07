from text2sql.embeddings.schema_embeddings import (
    build_schema_documents,
    create_schema_embeddings,
)


ids, documents = build_schema_documents()

print("Total documents:", len(documents))

print("\nFirst document:")
print(documents[0])

print("\nFirst document ID:")
print(ids[0])


ids, documents, embeddings = create_schema_embeddings()

print("\nEmbeddings created:", len(embeddings))
print("Embedding dimensions:", len(embeddings[0]))