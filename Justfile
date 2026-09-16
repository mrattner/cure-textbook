out_dir := 'out'

# Compile ConTeXt to PDF
compile TEX_FILEPATH:
    #!/usr/bin/env sh
    set -euo pipefail
    # The working directory must be the same as the source file being compiled
    # for component path resolution to work.
    cd $(dirname {{TEX_FILEPATH}})
    context --errors=list $(basename {{TEX_FILEPATH}}) || echo 'Compilation failed'
    # There isn't an option to set the output directory for `context`
    # executable, so just move the output files afterward
    mv *.{tuc,pdf,log,tua} {{justfile_directory()}}/{{out_dir}} || true

# Remove all files in the output dir
clean:
    rm {{justfile_directory()}}/{{out_dir}}/*.* || echo 'No outputs to clean.'

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
    mv docs/media/{{IMAGE_NAME}}.webp {{justfile_directory()}}

# Run the MetaTeX checker and the ChkTeX linter
check:
    mtxrun --script check **/*.tex
    @# 'Space in front of parenthesis' W36 not applicable in Japanese context.
    @# 'Inter-sentence space' W13 has false positives, not very useful.
    chktex -n36 -n13 -v --localrc .chktexrc **/*.tex
