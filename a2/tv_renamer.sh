#!/bin/bash

# Usage: ./tv_renamer.sh [seasonNumber] [folder_path]

# seasonNumber defaults to "1" if not provided.
seasonNumber="${1:-1}"

# Use the folder in the first argument or default to the current directory.
folder="${2:-.}"

seasonString=$(printf "S%02d" "$seasonNumber")

# Counter for if files don't match SxxExx format.
counter=1

# Loop through all items in the directory.
for file in "$folder"/*; do
    # Skip if not a regular file.
    [ -f "$file" ] || continue

    # Grab the extension.
    ext="${file##*.}"

    # Check for SxxExx format in the filename.
    if [[ "$file" =~ (S[0-9]{2}E[0-9]{2,3}) ]]; then
        newName="${BASH_REMATCH[1]}.$ext"
    else
        newName="${seasonString}E$(printf '%02d' "$counter").$ext"
    fi

    # Show operation and prompt for confirmation.
    echo "$file -> $newName"
    read -p "Confirm rename? (y/n) " choice
    if [[ "$choice" == [Yy]* ]]; then
        mv "$file" "$folder/$newName"
        ((counter++))
    else
        echo "Skipping rename for $file"
    fi
done

echo ""
echo "Finished!"
