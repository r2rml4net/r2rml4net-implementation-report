#!/bin/bash
set -u

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --database) database="$2"; shift ;;
        --engine) engine="$2"; shift ;;
        --output) output="$2"; shift ;;
        --base) baseUri="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

ConnectionString="Server=tcp:localhost,1433;User ID=sa;Password=$PASSWORD;Initial Catalog=$database"

r2rml4net direct \
    -c "$ConnectionString" \
    -o "$output" \
    -b "$baseUri" \
    --preserve-duplicate-rows
