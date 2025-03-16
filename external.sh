#!/bin/bash

# Set directories
dir="$(pwd)"
input_dir="$dir/input"
output_dir="$dir/output"
fonts_dir="$dir/fonts"
filetype=".mkv"
subtitle_extension=".tc.ass" # example: ".tc.ass"

# Load the fonts temporarily
#export FONTCONFIG_PATH="$fonts_dir"

# Change to the specified directory
cd "$input_dir" || exit 1

# Loop over .mkv files in the directory
for file in *$filetype; do
    # Get the filename without the extension
    filename="${file%$filetype}"
    
    # Set the subtitle filename (assuming subtitle file has the same name but different extension)
    subtitle_filename="$input_dir/$filename$subtitle_extension"
    
    # Print the filename
    echo "$filename"
    
    # Burn-in the subtitle (external)
    ffmpeg -v error -stats -i "$file" -vf "ass='$subtitle_filename':fontsdir=$fonts_dir" -c:v libx264 -c:a aac "$output_dir/$filename.mp4"
done

# Prompt user to press any key to exit
echo "Press any key to exit..."
read -n 1 -s

