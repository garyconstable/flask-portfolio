#!/bin/bash
set -e

echo "▶ Installing Playwright browsers and dependencies..."
npx playwright install --with-deps

echo "▶ Starting Gunicorn server..."
exec gunicorn app:app --bind 0.0.0.0:$PORT
