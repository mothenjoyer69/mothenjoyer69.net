#!/bin/bash
# usage: ./bloge.sh input.md output.html

html_template="$(dirname "$0")/blog/template.html"
if [ "$#" -ne 2 ]; then
  echo "usage: $0 input.md output.html"
  exit 1
fi

MD="$1"
HTML="$2"

MD_HTML=$(pandoc --from markdown --to html "$MD")

awk -v content="$MD_HTML" '
  BEGIN {found=0}
  /<!-- BLOG_CONTENT -->/ {
    print content
    found=1
    next
  }
  {print}
' "$html_template" > "$HTML"
