# Property Watch

A shareable, single-page buyer's-agent tool for running a recurring property watch.
Anyone who opens it sets their own brief: suburbs, budget ceiling, preferred spend, land size, pool, shed, access, solar and transport. The method stays the same for everyone:

- **Brief first.** Every property gets a fit score against the brief, and hard misses are flagged (over ceiling, too few beds, land too small, no pool and no room to build one).
- **Negotiation bands.** Each property has an opening offer, target, comfortable, limit and walk-away figure. A ruler shows where the current guide sits.
- **Due diligence.** Each property has a checklist covering current and future flood maps, an insurance quote for the address, building and pest, pool certificate, shed approval and power, easements, title and overlays, comparable sales and contract conditions.
- **Public sources only.** The Search tab builds realestate.com.au and Domain searches (for sale and sold) plus web searches for mortgagee, receiver, deceased-estate, auction, off-market and stale or reduced listings. Leads stay marked *unverified* until a public source confirms them.
- **Watch runs.** Each run records the current guide, status, days on market and a source link for every property, then logs what changed.
- **Report.** A plain-text summary covering what changed since the last run, how each priority property sits against its bands, new candidates and the watchlist.

The tool only records and compares. It never contacts agents or makes offers.

## Running it without a Claude account

The app is one HTML file with no server and no sign-in.

- **As a file:** download `docs/index.html` (rename it `property-watch.html` if you like) and open it in Chrome, Safari, Edge or Firefox. You can email it or put it on a USB stick or cloud drive. Data saves in that browser.
- **As a website (GitHub Pages):** `.github/workflows/pages.yml` publishes `docs/` on every push. Turn it on once under **Settings → Pages → Source: GitHub Actions**. GitHub Pages on a private repository needs a paid GitHub plan; on the free plan, make the repository public first. Once hosted, the site works offline after the first visit and can be added to a phone's home screen.
- **Any other static host** (Netlify, Cloudflare Pages, a web server): upload the contents of `docs/`.

## Data

Data stays in the viewer's own browser (`localStorage`). Use **Export backup** and **Import** to move it between devices or to hand a brief to someone else.

## Files

- `src/property-watch.html` is the page source, published as-is to claude.ai Artifacts.
- `scripts/build.sh` wraps it into the standalone `docs/index.html`, plus the web manifest, icon and offline service worker in `docs/`. Run it after editing the source.
