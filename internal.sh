#!/bin/bash

# Set directories
dir="$(pwd)"
input_dir="$dir/input"
output_dir="$dir/output"
fonts_dir="$dir/fonts"
filetype="mkv"

# Load the fonts temporarily
export FONTCONFIG_PATH="$fonts_dir"

# Change to the specified directory
cd "$input_dir" || exit 1

# Loop over .mkv files in the directory
for file in *.$filetype; do
    # Get the filename without the extension
    filename="${file%.$filetype}"
    
    # Print the filename
    echo "$filename"
    
    # Burn-in the subtitle (internal)
    ffmpeg -v error -stats -i "$file" -vf "subtitles='$file':si=1" -c:v libx264 -c:a aac "$output_dir/$filename.mp4"
done

# Prompt user to press any key to exit
echo "Press any key to exit..."
read -n 1 -s

