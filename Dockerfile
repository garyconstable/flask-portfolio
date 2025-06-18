FROM mcr.microsoft.com/playwright/python:v1.44.0-jammy

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Optional: install browsers at build time (redundant on Render)
RUN playwright install --with-deps

# Important: install browsers at runtime
CMD playwright install && gunicorn app:app --bind 0.0.0.0:10000
