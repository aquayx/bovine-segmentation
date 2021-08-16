#!/bin/bash
# generates dilated ground truths: grey, grey-as-white and grey-as-black images.
INPUT="./img/"
SKEL="./wshed/skel/"
OUTPUT="./wshed/"

# removes existing target directories (be careful, etc.)
rm -rf $SKEL

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$INPUT" "$SKEL"

# generates watershed skeletons
python3 mass_technique.py -i $INPUT -o $SKEL -t watershed -c gray -d 1 -a 1

rsync -a --include '*/' --exclude '*' "$SKEL" "$OUTPUT"

# dilates watershed skeletons
python3 mass_technique.py -i $SKEL -o $OUTPUT -t dilate -d 2 -v 1 -a 3
