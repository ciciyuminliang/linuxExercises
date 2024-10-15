#!/bin/bash

# Usage statement
if [ "$#" -lt 1 ]; then
  echo "Usage: ./mean.sh <column> [file.csv]" >&2
  exit 1
fi

# Assign column and file variables
column=$1
file=${2:-/dev/stdin}

# Check if the column is a valid number
if ! [[ "$column" =~ ^[0-9]+$ ]]; then
  echo "Error: <column> must be a number." >&2
  exit 1
fi

# Extract the specified column, skip the header, and calculate the mean
cut -d',' -f"$column" "$file" | tail -n +2 | {
  sum=0
  count=0
  while read value; do
    if [[ "$value" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
      sum=$(echo "$sum + $value" | bc)
      count=$((count + 1))
    fi
  done
  if [ "$count" -eq 0 ]; then
    echo "Error: No valid numeric data found in column $column." >&2
    exit 1
  fi
  mean=$(echo "scale=2; $sum / $count" | bc)
  echo "$mean"
}
