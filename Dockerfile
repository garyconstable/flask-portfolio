FROM mcr.microsoft.com/playwright/python:v1.44.0-jammy

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Install Playwright + dependencies at build time
RUN playwright install --with-deps

# Set default start command
CMD ["/bin/bash", "-c", "playwright install --with-deps && gunicorn app:app --bind 0.0.0.0:10000"]
