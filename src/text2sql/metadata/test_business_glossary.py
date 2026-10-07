from text2sql.metadata.business_glossary import (
    get_glossary_term,
    get_all_glossary_terms,
)


revenue = get_glossary_term("revenue")

print("Revenue definition:")
print(revenue["definition"])

print("\nRevenue synonyms:")
print(revenue["synonyms"])

print("\nRevenue related columns:")
for column in revenue["related_columns"]:
    print("-", column)


print("\nTotal glossary terms:")
print(len(get_all_glossary_terms()))