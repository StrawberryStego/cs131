#!/bin/bash

# Get the current date/time.
timestamp="$(date '+%F-%T')"

# List of vendor IDs.
vendors=("1.0" "2.0" "4.0")

for vendorID in "${vendors[@]}"
do
    outFile="${timestamp}-${vendorID}.csv"

    # Extract rows where the first column (vendorID) matches loop vendorID.
    awk -F, -v vendor="$vendorID" '$1 == vendor' 2019-01-h1.csv > "$outFile"

    echo "$outFile" >> .gitignore
done

# Create ws4.txt with line counts and .gitignore contents.
{
    wc "${timestamp}-1.0.csv"
    wc "${timestamp}-2.0.csv"
    wc "${timestamp}-4.0.csv"
    cat .gitignore
} > ws4.txt
