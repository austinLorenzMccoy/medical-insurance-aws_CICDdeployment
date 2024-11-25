# Use the official Python image as base
FROM python:3.10-slim-bullseye

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install AWS CLI using alternative method
RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip

# Copy the rest of the application
COPY . .

# Command to run the application
CMD ["python", "app.py"]