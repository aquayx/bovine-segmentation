#!/bin/bash
# applies watershed on the result of CNN predictions
INPUT_UNET="./bin/unet/"
SKEL_UNET="./wshed_cnn/unet/skel/"
OUTPUT_UNET="./wshed_cnn/unet/"

# removes existing target directories (be careful, etc.)
rm -rf $SKEL_UNET

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$INPUT_UNET" "$SKEL_UNET"

# generates watershed skeletons
python3 mass_technique.py -i $INPUT_UNET -o $SKEL_UNET -t watershed -d 2 -c gray -v 1

rsync -a --include '*/' --exclude '*' "$SKEL_UNET" "$OUTPUT_UNET"

# dilates watershed skeletons
python3 mass_technique.py -i $SKEL_UNET -o $OUTPUT_UNET -t skel_dilate -d 3 -v 1 -a 3


INPUT_POOLNET="./bin/poolnet/"
SKEL_POOLNET="./wshed_cnn/poolnet/skel/"
OUTPUT_POOLNET="./wshed_cnn/poolnet/"

# removes existing target directories (be careful, etc.)
rm -rf $SKEL_POOLNET

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$INPUT_POOLNET" "$SKEL_POOLNET"

# generates watershed skeletons
python3 mass_technique.py -i $INPUT_POOLNET -o $SKEL_POOLNET -t watershed -d 2 -c gray -v 1

rsync -a --include '*/' --exclude '*' "$SKEL_POOLNET" "$OUTPUT_POOLNET"

# dilates watershed skeletons
python3 mass_technique.py -i $SKEL_POOLNET -o $OUTPUT_POOLNET -t skel_dilate -d 3 -v 1 -a 3
