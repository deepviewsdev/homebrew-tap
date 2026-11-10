#!/usr/bin/env bash
# Point Casks/dictivo.rb at the release listed in https://dictivo.app/downloads.json.
# Prints the new version when the cask changed, nothing when it is current.
set -euo pipefail
cd "$(dirname "$0")/.."
json=$(curl -fsSL https://dictivo.app/downloads.json)
version=$(jq -r '.version' <<<"$json")
sha=$(jq -r '.artifacts[] | select(.platform == "macos") | .sha256' <<<"$json")
url=$(jq -r '.artifacts[] | select(.platform == "macos") | .url' <<<"$json")
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "bad version: $version" >&2; exit 1; }
[[ "$sha" =~ ^[0-9a-f]{64}$ ]] || { echo "bad sha256: $sha" >&2; exit 1; }
[[ "$url" == "https://downloads.dictivo.app/v${version}/Dictivo_${version}_universal.dmg" ]] || { echo "unexpected url: $url" >&2; exit 1; }
current=$(sed -nE 's/^  version "([^"]+)"$/\1/p' Casks/dictivo.rb)
[[ "$current" == "$version" ]] && exit 0
# Check the published checksum against the file before the cask points at it.
actual=$(curl -fsSL "$url" | shasum -a 256 | cut -d' ' -f1)
[[ "$actual" == "$sha" ]] || { echo "checksum mismatch for $url" >&2; exit 1; }
sed -i.bak -E "s/^  version \"[^\"]+\"$/  version \"${version}\"/; s/^  sha256 \"[0-9a-f]{64}\"$/  sha256 \"${sha}\"/" Casks/dictivo.rb
rm -f Casks/dictivo.rb.bak
echo "$version"
