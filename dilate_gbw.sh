#!/bin/bash
# generates dilated ground truths: grey, grey-as-white and grey-as-black images.
INPUT="./gts/_skel/"
OUTPUT_G="./gts/g/"
OUTPUT_B="./gts/b/"
OUTPUT_W="./gts/w/"
LEVELS=3

# removes existing target directories (be careful, etc.)
rm -rf $OUTPUT_G
rm -rf $OUTPUT_B
rm -rf $OUTPUT_W

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$INPUT" "$OUTPUT_G"
rsync -a --include '*/' --exclude '*' "$INPUT" "$OUTPUT_B"
rsync -a --include '*/' --exclude '*' "$INPUT" "$OUTPUT_W"

# runs mass technique script for dilation
python3 mass_technique.py -i $INPUT -o $OUTPUT_G -t dilate -c gray -r no -d 2 -a 3
python3 mass_technique.py -i $INPUT -o $OUTPUT_B -t dilate -c gray -r b -d 2 -a 3
python3 mass_technique.py -i $INPUT -o $OUTPUT_W -t dilate -c gray -r w -d 2 -a 3
