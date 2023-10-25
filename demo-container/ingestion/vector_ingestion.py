from pymilvus import (
    connections,
    utility,
    FieldSchema,
    CollectionSchema,
    DataType,
    Collection,
)

import os

print("Connecting to milvus...")

HOST = os.environ.get('MILVUS_HOST', "10.97.151.193")
PORT = os.environ.get('MILVUS_PORT', "19530")

connections.connect("default", host=HOST, port=PORT)

# Define the schema for the collection
fields = [
    FieldSchema(name="pk", dtype=DataType.INT64, is_primary=True, auto_id=False),
    FieldSchema(name="random", dtype=DataType.DOUBLE),
    FieldSchema(name="embeddings", dtype=DataType.FLOAT_VECTOR, dim=8)
]
schema = CollectionSchema(fields, "hello_milvus is the simplest demo to introduce the APIs")

# Create a collection with the defined schema
hello_milvus = Collection("hello_milvus", schema)

import random

# Generate sample entities for insertion
entities = [
    [i for i in range(10)],  # field pk
    [float(random.randrange(-20, -10)) for _ in range(10)],  # field random
    [[random.random() for _ in range(8)] for _ in range(10)]  # field embeddings
]

# Print the generated entities
print("Entities to insert:")
for entity in entities:
    print(entity)

# Insert the entities into the collection
insert_result = hello_milvus.insert(entities)
hello_milvus.flush()

# Define an index for the "embeddings" field
index = {
    "index_type": "IVF_FLAT",
    "metric_type": "L2",
    "params": {"nlist": 128},
}

# Create the index
hello_milvus.create_index("embeddings", index)
hello_milvus.load()

# Select the last embeddings for searching
vectors_to_search = entities[-1][-2:]

# Define search parameters
search_params = {
    "metric_type": "L2",
    "params": {"nprobe": 10},
}

# Perform a search using the selected vectors
result = hello_milvus.search(vectors_to_search, "embeddings", search_params, limit=3, output_fields=["random"])

