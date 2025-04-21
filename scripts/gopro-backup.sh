  #!/bin/bash

# Source and destination paths
SOURCE="/Volumes/Untitled/DCIM/100GOPRO"
DESTINATION="/Volumes/T9"

# Get current date in format YYYY-MM-DD
current_date=$(date +%d-%m-%Y)
folder_name="GOPROSD-64GB-$current_date"
target_folder="$DESTINATION/$folder_name"

# Create target folder if it doesn't exist
mkdir -p "$target_folder"

# Find video files in the GoPro SD card
find "$SOURCE" -type f \( -iname "*.mp4" -o -iname "*.mov" \) | while read -r file; do
    filename=$(basename "$file")
    
    # Check if file already exists anywhere in the destination
    if ! find "$DESTINATION" -type f -name "$filename" | grep -q .; then
        echo "Copying: $filename → $target_folder"
        cp "$file" "$target_folder"
    else
        echo "Already exists: $filename — skipping."
    fi
done
