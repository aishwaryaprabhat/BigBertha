# Use Ubuntu as the base image
FROM ubuntu:latest

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y g++ python3 python3-pip git htop redis-server

# Install Python packages using pip
RUN python3 -m pip install pymilvus

# Copy your Python script to the container
COPY vector_ingestion.py .

# Run the entrypoint script only if HUGGINGFACEHUB_API_TOKEN is available
CMD ["python3", "vector_ingestion.py"]
