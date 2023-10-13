#!/bin/sh

# Check if DOWNLOAD_LATER is set to false
if [ "$DOWNLOAD_LATER" = "false" ]; then
  # Run the Python script and capture its output as the environment variable
  export MODEL_LOCAL_PATH=$(python3 scripts/download_model.py)

  # Check if MODEL_LOCAL_PATH is empty
  if [ -z "$MODEL_LOCAL_PATH" ]; then
    echo "Python script execution failed or did not produce output. Exiting..."
    exit 1
  fi
else
  echo "Skipping model download as DOWNLOAD_LATER is set to true."
fi

# Start Redis with a custom configuration file
redis-server &

# Run the Streamlit app and Flask app using Gunicorn
python3 -m gunicorn scripts/metrics_reporter:app --bind 0.0.0.0:5000 --workers 3 &

python3 -m streamlit run scripts/app.py