# === Stage 1: Node.js Scraper ===
FROM node:18-slim AS scraper

# Prevent Puppeteer from downloading Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Install Chromium and dependencies
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    ca-certificates \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app

COPY package.json ./
RUN npm install --omit=dev
COPY scrape.js ./

# Provide URL to scrape via build arg
ARG SCRAPE_URL=https://example.com
ENV SCRAPE_URL=${SCRAPE_URL}

# Run the scraper
RUN node scrape.js

# === Stage 2: Minimal Flask Server ===
FROM python:3.10-alpine

# Install Flask only (no node, no chromium)
RUN pip install --no-cache-dir flask

WORKDIR /app

COPY server.py .
COPY --from=scraper /app/scraped_data.json .

EXPOSE 5000

CMD ["python3", "server.py"]

