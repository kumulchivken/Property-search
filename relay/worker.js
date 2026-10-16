// Property Watch search relay for Cloudflare Workers (free plan is plenty).
// Forwards listing searches from the app to Domain's official listings API,
// keeping the API key on the server and adding the CORS headers browsers need.
//
// Settings (Worker → Settings → Variables and Secrets):
//   DOMAIN_API_KEY   (secret)  your key from developer.domain.com.au
//   ALLOWED_ORIGINS  (text)    optional, comma-separated, e.g. https://you.github.io
//                              leave unset to allow any site to use the relay

const DOMAIN_SEARCH = "https://api.domain.com.au/v1/listings/residential/_search";
const ALLOWED_KEYS = ["listingType", "propertyTypes", "locations", "minBedrooms", "maxBedrooms", "minBathrooms", "maxBathrooms",
  "minPrice", "maxPrice", "minLandArea", "maxLandArea", "excludeDepositTaken", "excludePriceWithheld", "sort", "pageSize", "pageNumber"];

export default {
  async fetch(request, env) {
    const origin = request.headers.get("Origin") || "";
    const allowed = (env.ALLOWED_ORIGINS || "*").split(",").map((s) => s.trim()).filter(Boolean);
    const originOk = allowed.includes("*") || allowed.includes(origin);
    const cors = {
      "Access-Control-Allow-Origin": originOk ? origin || "*" : "null",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type",
      "Access-Control-Max-Age": "86400",
      Vary: "Origin",
    };
    const reply = (body, status) => new Response(body, { status, headers: { ...cors, "Content-Type": "text/plain" } });

    if (request.method === "OPTIONS") return new Response(null, { status: 204, headers: cors });
    if (!originOk) return reply("This site is not allowed to use the relay", 403);
    if (new URL(request.url).pathname !== "/search") return reply("Property Watch relay is running. POST searches to /search.", 200);
    if (request.method !== "POST") return reply("Use POST", 405);
    if (!env.DOMAIN_API_KEY) return reply("The relay has no DOMAIN_API_KEY set", 500);

    let query;
    try { query = JSON.parse(await request.text()); } catch { return reply("Body must be JSON", 400); }
    // Only pass through search fields, sale listings only, bounded page size.
    const clean = Object.fromEntries(Object.entries(query || {}).filter(([k]) => ALLOWED_KEYS.includes(k)));
    clean.listingType = "Sale";
    clean.pageSize = Math.min(Math.max(+clean.pageSize || 100, 1), 100);
    clean.pageNumber = Math.min(Math.max(+clean.pageNumber || 1, 1), 10);
    if (!Array.isArray(clean.locations) || !clean.locations.length || clean.locations.length > 60) return reply("Give between 1 and 60 suburbs", 400);

    const upstream = await fetch(DOMAIN_SEARCH, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-Api-Key": env.DOMAIN_API_KEY },
      body: JSON.stringify(clean),
    });
    return new Response(upstream.body, { status: upstream.status, headers: { ...cors, "Content-Type": "application/json" } });
  },
};
