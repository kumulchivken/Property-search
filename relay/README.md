# Search relay

The app gets live listings from Domain's official listings API. Browsers can't safely hold an API key or call Domain directly, so this small relay sits in between. It runs free on Cloudflare Workers.

Set it up once and everyone who opens your app can press **Run search** with no setup of their own.

## 1. Get a Domain API key (free)

1. Sign up at https://developer.domain.com.au and create a project.
2. In the project, add the **Listings Management** API (shown as **Agents & Listings** on some accounts). The free tier allows a limited number of calls per day.
3. Under **Credentials**, create an **API Key** and copy it.

## 2. Deploy the relay to Cloudflare (free)

1. Sign up at https://dash.cloudflare.com and open **Workers & Pages → Create → Create Worker**.
2. Name it, for example `property-search`, and press **Deploy**.
3. Press **Edit code**, replace everything with the contents of `worker.js`, then press **Deploy**.
4. Go to the Worker's **Settings → Variables and Secrets** and add:
   - `DOMAIN_API_KEY`, type **Secret**: your Domain key.
   - `ALLOWED_ORIGINS`, type **Text**: `https://kumulchivken.github.io` (so only your app can use it).
5. Copy the Worker's address, for example `https://property-search.yourname.workers.dev`.

## 3. Connect the app

Either:
- paste the Worker address into **Search → Search connection → Search service address** (that browser only), or
- set `DEFAULT_SEARCH_URL` near the top of `src/property-watch.html` to the address and push, so every visitor is connected automatically.

Each **Run search** uses one API call per 100 results (at most 3).
