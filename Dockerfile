# Use a lightweight Python image
FROM python:3.9-slim

# Set environment variables to avoid .pyc files and enable buffer-less logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory inside the container
WORKDIR /app

# Install system dependencies (for building certain Python packages like TensorFlow)
RUN apt-get update && apt-get install -y \
    libatlas-base-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code and model to the container
COPY . /app/

# Expose Flask port
EXPOSE 5000

# Run the Flask application
CMD ["python", "app.py"]