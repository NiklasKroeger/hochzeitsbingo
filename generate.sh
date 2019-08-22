#!/usr/bin/env bash
num="$1"
fnames=()

latexmk -C document.tex

for i in $(seq -w 1 $num); do
    echo "$i"
    latexmk -quiet -f --pdf document.tex
    fname="$i.pdf"
    fnames=("${fnames[@]}" "$fname")
    mv document.pdf "$fname"
done

latexmk -C document.tex

echo "Merging files into out.pdf"
#pdfjoin "${fnames[@]}" -o out.pdf
pdfjam --nup 2x1 --landscape --outfile out.pdf -- "${fnames[@]}" -

