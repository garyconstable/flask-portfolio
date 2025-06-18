# Use official Python image
FROM mcr.microsoft.com/playwright/python:v1.44.0-jammy

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY . .

# Install Playwright browsers
RUN playwright install --with-deps

# Set default start command
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
