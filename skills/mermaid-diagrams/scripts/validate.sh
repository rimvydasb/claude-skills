#!/usr/bin/env bash
# Validates every ```mermaid block in the given Markdown files by rendering it with Mermaid CLI.
# Usage: validate.sh FILE.md [FILE.md ...]
# Prints file:line and the parser error for each invalid block.
# Exit codes: 0 all diagrams valid, 1 at least one invalid diagram, 2 usage or environment error.
set -uo pipefail

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 FILE.md [FILE.md ...]" >&2
  exit 2
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "error: npx not found. Install Node.js to validate Mermaid diagrams." >&2
  exit 2
fi

work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

# Chromium inside Mermaid CLI cannot start its sandbox in some containers.
printf '{"args":["--no-sandbox"]}' > "$work_dir/puppeteer.json"
index="$work_dir/index.tsv"
: > "$index"

file_number=0
for file in "$@"; do
  if [ ! -f "$file" ]; then
    echo "error: file not found: $file" >&2
    exit 2
  fi
  file_number=$((file_number + 1))
  awk -v dir="$work_dir" -v file="$file" -v file_number="$file_number" '
    /^[[:space:]]*```mermaid[[:space:]]*$/ {
      in_block = 1
      block_number++
      out = sprintf("%s/%d_%d.mmd", dir, file_number, block_number)
      printf "%s\t%d\t%s\n", file, NR, out >> (dir "/index.tsv")
      printf "" > out
      next
    }
    in_block && /^[[:space:]]*```[[:space:]]*$/ { in_block = 0; close(out); next }
    in_block { print > out }
    END { if (in_block) printf "%s\t%d\n", file, NR >> (dir "/unclosed.tsv") }
  ' "$file"
done

failures=0
if [ -f "$work_dir/unclosed.tsv" ]; then
  while IFS=$'\t' read -r file line; do
    echo "INVALID $file:$line - the mermaid code fence is not closed"
    failures=$((failures + 1))
  done < "$work_dir/unclosed.tsv"
fi

total=0
while IFS=$'\t' read -r file line block; do
  total=$((total + 1))
  if ! output="$(npx -y -p @mermaid-js/mermaid-cli mmdc -q -p "$work_dir/puppeteer.json" \
      -i "$block" -o "$block.svg" 2>&1)"; then
    failures=$((failures + 1))
    echo "INVALID $file:$line"
    # Keep the parser message; drop JavaScript stack frames and blank lines.
    printf '%s\n' "$output" \
      | grep -v -E '^[[:space:]]+at |node_modules|^[[:space:]]*$' \
      | head -n 6 | sed 's/^/  /'
  fi
done < "$index"

if [ "$total" -eq 0 ] && [ "$failures" -eq 0 ]; then
  echo "No Mermaid diagrams found."
  exit 0
fi

echo "Checked $total diagram(s): $failures invalid."
[ "$failures" -eq 0 ]
