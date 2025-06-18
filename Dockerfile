FROM python:3.11-slim

# Install OS packages required by Playwright
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libasound2 \
    libxshmfence1 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxss1 \
    libxext6 \
    libxfixes3 \
    libxrender1 \
    libx11-6 \
    libxtst6 \
    libappindicator1 \
    libindicator7 \
    libgl1 \
    fonts-liberation \
    libenchant-2-2 \
    libsecret-1-0 \
    libgles2 && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright + Browsers
RUN pip install playwright && playwright install --with-deps

COPY . .

# Expose the correct port for Render
EXPOSE 10000

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
