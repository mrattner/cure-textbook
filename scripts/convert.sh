#!/usr/bin/env sh

set -euo pipefail

for i in docs/en/*.md; do
  export newname=`basename $i .md`
  pandoc -f markdown -t context -o "docs/raw/$newname.tex" "$i" --wrap=none
  echo "converted $i to $newname.tex"
done
