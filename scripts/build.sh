#!/usr/bin/env sh
# Builds the standalone app: wraps src/property-watch.html in a full HTML page,
# inlines the suburb list from data/suburbs.json, and writes docs/index.html.
# The result runs with no sign-in: open it as a file or host docs/ anywhere.
set -e
cd "$(dirname "$0")/.."
python3 - <<'PY'
import json
body = open("src/property-watch.html", encoding="utf-8").read()
suburbs = json.dumps(json.load(open("data/suburbs.json", encoding="utf-8")), separators=(",", ":"))
marker = "/*__SUBURBS__*/null"
assert marker in body, "suburb placeholder missing from src/property-watch.html"
body = body.replace(marker, suburbs)
head = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#1f6b55">
<meta name="description" content="Buyer's-agent property search: set your suburbs and budget, search listings, score them against your brief and track negotiation bands.">
<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" href="icon.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="icon.svg">
<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%}[hidden]{display:none!important}</style>
</head>
<body>
"""
# Offline support and "Add to Home Screen" when served over http(s); skipped for file://
tail = """
<script>if("serviceWorker" in navigator && location.protocol.startsWith("http")) navigator.serviceWorker.register("sw.js").catch(function(){});</script>
</body>
</html>
"""
open("docs/index.html", "w", encoding="utf-8").write(head + body + tail)
PY
echo "Built docs/index.html"
