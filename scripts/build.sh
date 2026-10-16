#!/usr/bin/env sh
# Wraps src/property-watch.html (a page body, as published to claude.ai Artifacts)
# into a standalone docs/index.html that runs with no sign-in: open the file
# directly in a browser, or host docs/ on any static host (GitHub Pages etc.).
set -e
cd "$(dirname "$0")/.."
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<meta name="theme-color" content="#1f6b55">\n'
  printf '<meta name="description" content="Buyer'"'"'s-agent property watch: set your own suburbs and budget, score listings, track negotiation bands and changes.">\n'
  printf '<link rel="manifest" href="manifest.webmanifest">\n'
  printf '<link rel="icon" href="icon.svg" type="image/svg+xml">\n'
  printf '<link rel="apple-touch-icon" href="icon.svg">\n'
  printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  printf '</head>\n<body>\n'
  cat src/property-watch.html
  # Offline support and "Add to Home Screen" when served over http(s); skipped for file://
  printf '\n<script>if("serviceWorker" in navigator && location.protocol.startsWith("http")) navigator.serviceWorker.register("sw.js").catch(function(){});</script>\n'
  printf '</body>\n</html>\n'
} > docs/index.html
echo "Built docs/index.html"
