FROM mcr.microsoft.com/playwright/python:v1.44.0-jammy

WORKDIR /app

# Install missing dependencies for browser runtime
RUN apt-get update && \
    apt-get install -y \
        libgtk-4-1 \
        libgraphene-1.0-0 \
        libgstgl-1.0-0 \
        libgstcodecparsers-1.0-0 \
        libenchant-2-2 \
        libsecret-1-0 \
        libmanette-0.2-0 \
        libgles2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Install Playwright browsers with required deps
RUN playwright install --with-deps

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
