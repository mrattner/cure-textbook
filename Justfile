out_dir := 'out'

# Compile ConTeXt to PDF
compile TEX_FILEPATH:
    cd {{justfile_directory()}}/{{out_dir}} && context --errors=list {{justfile_directory()}}/{{TEX_FILEPATH}}

# Remove all files in the output dir
clean:
    rm out/*.*

# Convert the referenced image to PNG and save as next figure no.
nextfigure IMAGE_NAME:
    #!/usr/bin/env sh
    set -euo pipefail
    # Find name of highest existing figure no.
    last=$(ls media/figure*.png | sort | tail -n1)
    # Extract everything after 'figure'
    num=${last##*figure}
    # Strip the suffix '.png'
    num=${num%.png}
    echo "Last figure was figure$num"
    # Remove padded zeros before incrementing
    num=$(echo "$num" | sed 's/^0*//')
    num=$((num + 1))
    # Re-pad to 4 digits
    nextfig=$(printf "figure%04d.png" "$num")
    dwebp docs/media/{{IMAGE_NAME}}.webp -o media/$nextfig
