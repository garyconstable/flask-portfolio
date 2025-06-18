#!/bin/bash

echo "[BOOT] Installing Playwright browsers..."
playwright install --with-deps

echo "[BOOT] Starting Gunicorn..."
exec gunicorn app:app
