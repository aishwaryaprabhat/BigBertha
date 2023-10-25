#!/bin/bash

# Run the Python script
pip3 install -r requirements.txt --no-warn-script-location
python3 ingestion/llama_ingestion.py
