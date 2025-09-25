#!/bin/bash
# usage: ./bloge.sh input.md output.html
MD="$1"
HTML="$2"
TEMPLATE="$(dirname "$0")/blog/template.html"
if [ "$#" -ne 2 ]; then
  echo "usage: $0 input.md output.html"
  exit 1
fi


# convert md to html and add ids so i can format it later
MD_HTML=$(pandoc --from markdown --to html "$MD" | sed -E 's/<h([1-6])[^>]*>/<h\1 id="mdheader\1">/g')

# insert it
awk -v content="$MD_HTML" '
  BEGIN {found=0}
  /<!-- BLOG_CONTENT -->/ {
    print content
    found=1
    next
  }
  {print}
' "$TEMPLATE" > "$HTML"
