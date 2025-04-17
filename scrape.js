// scrape.js
const fs = require('fs');
const puppeteer = require('puppeteer');

const url = process.env.SCRAPE_URL;

if (!url) {
  console.error('SCRAPE_URL not provided!');
  process.exit(1);
}

(async () => {
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox'],
    executablePath: '/usr/bin/chromium'
  });
  const page = await browser.newPage();
  await page.goto(url, { waitUntil: 'domcontentloaded' });

  const data = await page.evaluate(() => ({
    title: document.title,
    heading: document.querySelector('h1')?.innerText || 'No <h1> found',
  }));

  console.log(data);

  fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
  await browser.close();
})();

