from text2sql.vector_store.search import search_metadata


query = "Which products generated the most revenue?"

results = search_metadata(query, top_k=5)


print("Query:")
print(query)

print("\nRetrieved metadata:")

for document, distance in zip(
    results["documents"][0],
    results["distances"][0],
):
    print("\n---")
    print("Distance:", distance)
    print(document)