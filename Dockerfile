# Use a lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies for Playwright + Chromium
RUN apt-get update && apt-get install -y \
    wget gnupg ca-certificates curl unzip fonts-liberation libnss3 libatk-bridge2.0-0 libxss1 \
    libgtk-3-0 libasound2 libxcomposite1 libxrandr2 libxdamage1 libx11-xcb1 libgbm1 libxshmfence1 \
    libglu1-mesa libenchant-2-2 libsecret-1-0 libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 \
    libgraphene-1.0-0 libmanette-0.2-0 libgles2 libgstgl-1.0-0 libgstcodecparsers-1.0-0 \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright + download browsers at build time
RUN pip install playwright && playwright install --with-deps

# Copy app code
COPY . .

# Expose port for Render
EXPOSE 10000

# Run app
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
