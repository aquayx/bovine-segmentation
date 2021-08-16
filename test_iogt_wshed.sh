#!/bin/bash
# runs testing by pixel-based metric for all predictions
GT_BX="./gts/b/x/"
GT_BY="./gts/b/y/"
GT_WX="./gts/w/x/"
GT_WY="./gts/w/y/"

PRED_WSHED_X="./wshed/x/"
PRED_WSHED_Y="./wshed/y/"
OUTPUT_WSHED_BX="./results/iogt/wshed/b/x/"
OUTPUT_WSHED_BY="./results/iogt/wshed/b/y/"
OUTPUT_WSHED_WX="./results/iogt/wshed/w/x/"
OUTPUT_WSHED_WY="./results/iogt/wshed/w/y/"

# removes existing target directories (be careful, etc.)
rm -rf $OUTPUT_WSHED_BX
rm -rf $OUTPUT_WSHED_BY
rm -rf $OUTPUT_WSHED_WX
rm -rf $OUTPUT_WSHED_WY

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$PRED_WSHED_X" "$OUTPUT_WSHED_BX"
rsync -a --include '*/' --exclude '*' "$PRED_WSHED_Y" "$OUTPUT_WSHED_BY"
rsync -a --include '*/' --exclude '*' "$PRED_WSHED_X" "$OUTPUT_WSHED_WX"
rsync -a --include '*/' --exclude '*' "$PRED_WSHED_Y" "$OUTPUT_WSHED_WY"

echo "Network: Watershed | Grey as: Negative | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_WSHED_X -o $OUTPUT_WSHED_BX -m iogt -c bw
echo "Network: Watershed | Grey as: Negative | Test: y"
python3 mass_metrics.py -g $GT_BX -p $PRED_WSHED_Y -o $OUTPUT_WSHED_BY -m iogt -c bw
echo "Network: Watershed | Grey as: Positive | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_WSHED_X -o $OUTPUT_WSHED_WX -m iogt -c bw
echo "Network: Watershed | Grey as: Positive | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_WSHED_Y -o $OUTPUT_WSHED_WY -m iogt -c bw
