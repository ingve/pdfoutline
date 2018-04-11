#!/usr/bin/env bash
IFS=$'\n'
if [ "$#" -ne 1 ]; then
  echo "folder path is required"
  exit 1
fi
files=$(ls $1/*.pdf)
for f in $files
do
  echo "$f"
  ./pdfoutline $f > /dev/null
  if [ $? -eq 0 ]; then
    ./pdfoutline $f > $f.txt
  fi
done
