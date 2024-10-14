#!/bin/bash

gh attestation download Lib.fs -R "$GH_REPOSITORY"

mapfile -d $'\0' files < <(find . -maxdepth 1 -type f -name '*.jsonl' -print0)

file_count=${#files[@]}
if [ "$file_count" -ne "1" ]; then
  echo "Expected exactly one jsonl file! ${files[*]}"
  exit 1
fi

written_file="${files[0]}"
mv "$written_file" "$ATT_OUTPUT"
echo "outfile=$ATT_OUTPUT" >> "$GITHUB_OUTPUT"
