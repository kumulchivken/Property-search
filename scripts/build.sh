#!/usr/bin/env sh
# Wraps src/property-watch.html (a page body, as published to claude.ai Artifacts)
# into a standalone docs/index.html for GitHub Pages or any static host.
set -e
cd "$(dirname "$0")/.."
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  printf '</head>\n<body>\n'
  cat src/property-watch.html
  printf '\n</body>\n</html>\n'
} > docs/index.html
echo "Built docs/index.html"
