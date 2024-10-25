#!/bin/bash

# Check if virtual environment exists, if not, create it
if [ ! -d "venv" ]; then
  echo "Creating virtual environment..."
  python -m venv venv
fi

# Activate the virtual environment (use Scripts for Windows)
echo "Activating virtual environment..."
if [[ "$OSTYPE" == "msys" ]]; then
  # For Windows
  source venv/Scripts/activate
else
  # For Linux/Mac
  source venv/bin/activate
fi

# Upgrade pip to the latest version
echo "Upgrading pip..."
pip install --upgrade pip

# Install dependencies from requirements.txt
echo "Installing dependencies from requirements.txt..."
pip install -r server/requirements.txt

# Run the FastAPI application using gunicorn with uvicorn worker
echo "Starting FastAPI application with gunicorn..."
gunicorn -w 4 -k uvicorn.workers.UvicornWorker server.main:app --bind 0.0.0.0:8000