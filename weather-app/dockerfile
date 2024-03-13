# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install dependencies
COPY requirements.txt .
COPY weather-fetcher.py .
COPY store_to_cloud.py .
RUN pip install -r requirements.txt 
RUN pip install boto3 python-dotenv

# Copy the current directory contents into the container at /app
# COPY . /app

# Set AWS credentials as environment variables
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_REGION=${AWS_DEFAULT_REGION}

# Run the Python script
CMD ["python", "weather-fetcher.py"]
