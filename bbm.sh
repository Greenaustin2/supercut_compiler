#!/bin/bash

input_folder="/Volumes/graphic_balance/supercut/input"
output_folder="/Volumes/graphic_balance/supercut/output"
concatenated_output_file="${output_folder}/concatenated_output.mp4"
temp_file="/tmp/filelist.txt"

# Create the output folder if it doesn't exist
mkdir -p "$output_folder"

Iterate through all video files in the input folder


for file in "$input_folder"/*.mp4; do
    if [ -f "$file" ]; then
        
        # Generate a unique output file name based on the input file
        output_file="${output_folder}/output_$(basename "$file")"

        # # ffmpeg command for each input file (re-encode)
        # ffmpeg -i "$file" -c:v libx264 -c:a aac -r 30 "$output_file"
        
        # ffmpeg command for each input file (re-encode) with text overlay
        ffmpeg -i "$file" -c:v libx264 -c:a aac -r 30 -vf "drawtext=text='$(basename "$file")':font='Times New Roman':x=(w-text_w)/2:y=h-th:fontsize=(h/30):fontcolor=Fuchsia:box=1:boxcolor=white@0:boxborderw=0" "$output_file"


        # Record the output file in the temporary file
        echo "file '$output_file'" >> "$temp_file"
    fi
done

# Change to the output folder
cd "$output_folder" || exit

# Concatenate all files in the output folder
ffmpeg -f concat -safe 0 -i "$temp_file" -c:v libx264 -c:a aac -r 30 "${concatenated_output_file}"

# Remove the temporary file
rm "$temp_file"

# for f in *.mp4; do echo "file '$f'" >> mylist.txt; done
# ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.mp4
