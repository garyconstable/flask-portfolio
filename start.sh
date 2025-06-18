#!/bin/bash

echo "[STARTUP] Installing Playwright browsers in runtime..."
playwright install --with-deps

echo "[STARTUP] Launching Gunicorn..."
exec gunicorn app:app
