# Property Watch

A shareable buyer's-agent property search app. Anyone who opens it sets their own brief: suburbs, budget, property type, bedrooms, land, yield target for investors, and features like pool or shed. The method stays the same for everyone.

**Live app:** https://kumulchivken.github.io/Property-search/

- **Brief first.** Type a suburb or postcode and the full name, state and postcode fill in from a built-in list of about 17,800 Australian suburbs.
- **One-button search.** **Run search** searches every suburb in the brief at once using Domain's official listings API, and shows every result on one Results page with a photo, price, beds, baths, land and a link to view the listing.
- **Scored against the brief.** Each result gets a fit score and red flags for hard misses (over the ceiling, too few bedrooms, land too small). Auction, mortgagee, deceased-estate, price-reduced and long-on-market signals are read from the listing text.
- **Changes between searches.** Each search marks new listings, price changes, and listings that have dropped out since the last search.
- **Tracking.** Press **Track** to move a result into My properties, where it gets negotiation bands (opening offer, target, comfortable, limit, walk-away), comparable sales, rent and gross yield for investors, and a due diligence checklist.
- **Watch runs and report.** Record status changes over time and copy a plain-text summary of the latest search, priority properties against their bands, candidates and the watchlist.

The app only searches, records and compares. It never contacts agents or makes offers.

## Connecting the search

Live results need a free Domain developer API key. Two ways to use it:

- **For everyone (recommended):** deploy the small relay in [`relay/`](relay/README.md) to Cloudflare Workers (free), then set `DEFAULT_SEARCH_URL` in `src/property-watch.html` to its address. Visitors can then search with no setup.
- **Just you:** paste your key into **Search → Search connection** in the app. Some browsers block calling Domain directly; if so, use the relay.

Without a connection, the Search tab still offers links that open the same search on realestate.com.au and Domain.

## Running it

The app is one HTML file with no server and no sign-in.

- **Website:** `.github/workflows/pages.yml` builds and publishes `docs/` to GitHub Pages on every push.
- **As a file:** download `docs/index.html` and open it in any browser. Data saves in that browser.
- **Any other static host:** upload the contents of `docs/`.

## Data

Each person's brief, properties and results stay in their own browser (`localStorage`). **Export backup** and **Import** move them between devices or to someone else; backups never include an API key.

Suburb names and postcodes come from the community-maintained [Australian Postcodes](https://github.com/matthewproctor/australianpostcodes) dataset (delivery areas only).

## Files

- `src/property-watch.html` is the app source.
- `data/suburbs.json` is the suburb list.
- `scripts/build.sh` inlines the suburb list and writes the standalone `docs/index.html`. Run it after editing the source; the Pages workflow also runs it.
- `docs/` holds the built app, web manifest, icon and offline service worker.
- `relay/` holds the Cloudflare Worker that connects the app to Domain's API.
