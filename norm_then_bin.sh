#!/bin/bash
# normalizes and then binarizes a set of images (most likely, the output of a CNN)
INPUT_UNET="./unet/"
OUTPUT_NORM_UNET="./norm/unet/"
OUTPUT_BIN_UNET="./bin/unet/"
INPUT_POOLNET="./poolnet/"
OUTPUT_NORM_POOLNET="./norm/poolnet/"
OUTPUT_BIN_POOLNET="./bin/poolnet/"

# removes existing target directories (be careful, etc.)
rm -rf $OUTPUT_NORM_UNET
rm -rf $OUTPUT_BIN_UNET
rm -rf $OUTPUT_NORM_POOLNET
rm -rf $OUTPUT_BIN_POOLNET

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$INPUT_UNET" "$OUTPUT_NORM_UNET"
rsync -a --include '*/' --exclude '*' "$INPUT_UNET" "$OUTPUT_BIN_UNET"
rsync -a --include '*/' --exclude '*' "$INPUT_POOLNET" "$OUTPUT_NORM_POOLNET"
rsync -a --include '*/' --exclude '*' "$INPUT_POOLNET" "$OUTPUT_BIN_POOLNET"

# unet normalization into binarization
python3 mass_technique.py -i $INPUT_UNET -o $OUTPUT_NORM_UNET -t norm -c gray -d 1 -v 1
python3 mass_technique.py -i $OUTPUT_NORM_UNET -o $OUTPUT_BIN_UNET -t bin -c gray -a adapt 99 -v 1
# poolnet normalization into binarization
python3 mass_technique.py -i $INPUT_POOLNET -o $OUTPUT_NORM_POOLNET -t norm -c gray -d 1 -v 1  # runs normalization
python3 mass_technique.py -i $OUTPUT_NORM_POOLNET -o $OUTPUT_BIN_POOLNET -t bin -c gray -a adapt 99 -v 1 # runs binarization
