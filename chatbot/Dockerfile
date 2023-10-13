# Use Ubuntu as the base image
FROM ubuntu:latest

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y g++ python3 python3-pip git htop redis-server

# Create a non-root user
RUN useradd -ms /bin/bash llamauser

# Set the working directory
WORKDIR /home/llamademo

# Expose ports for Streamlit and Flask
EXPOSE 8501
EXPOSE 5000

# Define environment variables with default values
ENV HUGGINGFACEHUB_API_TOKEN=
ENV HF_REPO=TheBloke/Llama-2-7B-chat-GGML
ENV HF_MODEL_FILE=llama-2-7b-chat.ggmlv3.q2_K.bin
ENV DOWNLOAD_LATER=false

# Copy the necessary files into the container
COPY app.py .
COPY metrics_reporter.py .
COPY download_model.py .
COPY entrypoint.sh .
COPY requirements.txt .

# Set execute permissions on the entrypoint script
RUN chmod +x entrypoint.sh

# Install required Python packages
RUN pip3 install -r requirements.txt

USER llamauser

# Run the entrypoint script only if HUGGINGFACEHUB_API_TOKEN is available
RUN cat entrypoint.sh
CMD if [ -n "$HUGGINGFACEHUB_API_TOKEN" ]; then ./entrypoint.sh; else echo "HUGGINGFACEHUB_API_TOKEN is required"; exit 1; fi
