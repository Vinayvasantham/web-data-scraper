# Web Data Scraper with Flask API

This project is a lightweight web data scraper that uses **Puppeteer** (Node.js) to scrape webpage data and serves it using a **Flask (Python)** API. It is containerized using a **multi-stage Dockerfile** to minimize final image size.

---

## Features

- Headless scraping using Puppeteer and Chromium
- Lightweight multi-stage Docker image
- Flask server to expose scraped data via HTTP
- Pass dynamic URLs for scraping via environment variables

---

## How to Build the Docker Image

```bash
docker build -t web-data-scraper .
```

This command will build the Docker image using the multi-stage Dockerfile and tag it as `web-data-scraper`.

---

## How to Run the Container

You can run the container using:

```bash
docker run -p 5000:5000 web-data-scraper
```

By default, it will scrape data from `https://example.com`.

---

## How to Pass the URL to Be Scraped

You can override the default URL by setting the `SCRAPE_URL` environment variable when running the container:

```bash
docker build --build-arg SCRAPE_URL="https://example.com" -t web-data-scraper .
```

This will tell Puppeteer to scrape the provided URL.

---

## 🔍 How to Access the Hosted Scraped Data

Once the container is running, open your browser and visit:

```
http://localhost:5000
```

You will see the scraped data (like page title, headers, etc.) returned as JSON by the Flask API.

---

## Cleanup Tips

To remove dangling intermediate images created during multi-stage builds:

```bash
docker image prune -f
```

---

## Example Output

If you scrape `https://example.com`, you’ll get:

```json
{
  "title": "Example Domain",
  "headers": ["Example Domain"]
}
```

---

## Note

- Make sure the target site is accessible from your network.
- Chromium must be available in the final image for Puppeteer to work (included via Alpine).

---

Happy scraping!
