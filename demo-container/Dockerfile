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
ENV HF_REPO=TheBloke/Llama-2-7B-chat-GGML
ENV HF_MODEL_FILE=llama-2-7b-chat.ggmlv3.q2_K.bin
ENV DOWNLOAD_LATER=false

# Install required Python packages
COPY requirements.txt .

# Copy the necessary files into the container
COPY chatbot chatbot
COPY ingestion ingestion

# Set necessary permissions and user
# RUN chmod +x entrypoint.sh
RUN chmod -R 777 /home
USER llamauser

CMD ["chatbot/entrypoint.sh"]
