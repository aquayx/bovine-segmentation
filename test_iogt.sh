#!/bin/bash
# runs testing by pixel-based metric for all predictions
GT_BX="./gts/b/x/"
GT_BY="./gts/b/y/"
GT_WX="./gts/w/x/"
GT_WY="./gts/w/y/"
PRED_TRAIN_UNET_X="./bin/unet/train_x/"
PRED_TRAIN_UNET_Y="./bin/unet/train_y/"
OUTPUT_TRAIN_UNET_X="./results/iogt/unet/train_x/"
OUTPUT_TRAIN_UNET_Y="./results/iogt/unet/train_y/"
PRED_TRAIN_UNET_XBX="./bin/unet/train_x/b/x/"
PRED_TRAIN_UNET_XBY="./bin/unet/train_x/b/y/"
PRED_TRAIN_UNET_XWX="./bin/unet/train_x/w/x/"
PRED_TRAIN_UNET_XWY="./bin/unet/train_x/w/y/"
PRED_TRAIN_UNET_YBX="./bin/unet/train_y/b/x/"
PRED_TRAIN_UNET_YBY="./bin/unet/train_y/b/y/"
PRED_TRAIN_UNET_YWX="./bin/unet/train_y/w/x/"
PRED_TRAIN_UNET_YWY="./bin/unet/train_y/w/y/"
OUTPUT_TRAIN_UNET_XBX="./results/iogt/unet/train_x/b/x/"
OUTPUT_TRAIN_UNET_XBY="./results/iogt/unet/train_x/b/y/"
OUTPUT_TRAIN_UNET_XWX="./results/iogt/unet/train_x/w/x/"
OUTPUT_TRAIN_UNET_XWY="./results/iogt/unet/train_x/w/y/"
OUTPUT_TRAIN_UNET_YBX="./results/iogt/unet/train_y/b/x/"
OUTPUT_TRAIN_UNET_YBY="./results/iogt/unet/train_y/b/y/"
OUTPUT_TRAIN_UNET_YWX="./results/iogt/unet/train_y/w/x/"
OUTPUT_TRAIN_UNET_YWY="./results/iogt/unet/train_y/w/y/"

# removes existing target directories (be careful, etc.)
rm -rf $OUTPUT_TRAIN_UNET_XBX
rm -rf $OUTPUT_TRAIN_UNET_XBY
rm -rf $OUTPUT_TRAIN_UNET_XWX
rm -rf $OUTPUT_TRAIN_UNET_XWY
rm -rf $OUTPUT_TRAIN_UNET_YBX
rm -rf $OUTPUT_TRAIN_UNET_YBY
rm -rf $OUTPUT_TRAIN_UNET_YWX
rm -rf $OUTPUT_TRAIN_UNET_YWY

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$PRED_TRAIN_UNET_X" "$OUTPUT_TRAIN_UNET_X"
rsync -a --include '*/' --exclude '*' "$PRED_TRAIN_UNET_Y" "$OUTPUT_TRAIN_UNET_Y"

echo "Network: U-net | Grey as: Negative | Train: x | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_UNET_XBX -o $OUTPUT_TRAIN_UNET_XBX -m iogt -c bw
echo "Network: U-net | Grey as: Negative | Train: x | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_UNET_XBY -o $OUTPUT_TRAIN_UNET_XBY -m iogt -c bw
echo "Network: U-net | Grey as: Positive | Train: x | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_UNET_XWX -o $OUTPUT_TRAIN_UNET_XWX -m iogt -c bw
echo "Network: U-net | Grey as: Positive | Train: x | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_UNET_XWY -o $OUTPUT_TRAIN_UNET_XWY -m iogt -c bw
echo "Network: U-net | Grey as: Negative | Train: y | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_UNET_YBX -o $OUTPUT_TRAIN_UNET_YBX -m iogt -c bw
echo "Network: U-net | Grey as: Negative | Train: y | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_UNET_YBY -o $OUTPUT_TRAIN_UNET_YBY -m iogt -c bw
echo "Network: U-net | Grey as: Positive | Train: y | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_UNET_YWX -o $OUTPUT_TRAIN_UNET_YWX -m iogt -c bw
echo "Network: U-net | Grey as: Positive | Train: y | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_UNET_YWY -o $OUTPUT_TRAIN_UNET_YWY -m iogt -c bw


PRED_TRAIN_POOLNET_X="./bin/poolnet/train_x/"
PRED_TRAIN_POOLNET_Y="./bin/poolnet/train_y/"
OUTPUT_TRAIN_POOLNET_X="./results/iogt/poolnet/train_x/"
OUTPUT_TRAIN_POOLNET_Y="./results/iogt/poolnet/train_y/"
PRED_TRAIN_POOLNET_XBX="./bin/poolnet/train_x/b/x/"
PRED_TRAIN_POOLNET_XBY="./bin/poolnet/train_x/b/y/"
PRED_TRAIN_POOLNET_XWX="./bin/poolnet/train_x/w/x/"
PRED_TRAIN_POOLNET_XWY="./bin/poolnet/train_x/w/y/"
PRED_TRAIN_POOLNET_YBX="./bin/poolnet/train_y/b/x/"
PRED_TRAIN_POOLNET_YBY="./bin/poolnet/train_y/b/y/"
PRED_TRAIN_POOLNET_YWX="./bin/poolnet/train_y/w/x/"
PRED_TRAIN_POOLNET_YWY="./bin/poolnet/train_y/w/y/"
OUTPUT_TRAIN_POOLNET_XBX="./results/iogt/poolnet/train_x/b/x/"
OUTPUT_TRAIN_POOLNET_XBY="./results/iogt/poolnet/train_x/b/y/"
OUTPUT_TRAIN_POOLNET_XWX="./results/iogt/poolnet/train_x/w/x/"
OUTPUT_TRAIN_POOLNET_XWY="./results/iogt/poolnet/train_x/w/y/"
OUTPUT_TRAIN_POOLNET_YBX="./results/iogt/poolnet/train_y/b/x/"
OUTPUT_TRAIN_POOLNET_YBY="./results/iogt/poolnet/train_y/b/y/"
OUTPUT_TRAIN_POOLNET_YWX="./results/iogt/poolnet/train_y/w/x/"
OUTPUT_TRAIN_POOLNET_YWY="./results/iogt/poolnet/train_y/w/y/"

PRED_TRAIN_POOLNET_GRAY_XGX="./bin/poolnet/train_x/g/x/"
PRED_TRAIN_POOLNET_GRAY_XGY="./bin/poolnet/train_x/g/y/"
PRED_TRAIN_POOLNET_GRAY_YGX="./bin/poolnet/train_y/g/x/"
PRED_TRAIN_POOLNET_GRAY_YGY="./bin/poolnet/train_y/g/y/"
OUTPUT_TRAIN_POOLNET_GRAY_XGX="./results/iogt/poolnet/train_x/g/x/"
OUTPUT_TRAIN_POOLNET_GRAY_XGY="./results/iogt/poolnet/train_x/g/y/"
OUTPUT_TRAIN_POOLNET_GRAY_YGX="./results/iogt/poolnet/train_y/g/x/"
OUTPUT_TRAIN_POOLNET_GRAY_YGY="./results/iogt/poolnet/train_y/g/y/"

# removes existing target directories (be careful, etc.)
rm -rf $OUTPUT_TRAIN_POOLNET_XBX
rm -rf $OUTPUT_TRAIN_POOLNET_XBY
rm -rf $OUTPUT_TRAIN_POOLNET_XWX
rm -rf $OUTPUT_TRAIN_POOLNET_XWY
rm -rf $OUTPUT_TRAIN_POOLNET_YBX
rm -rf $OUTPUT_TRAIN_POOLNET_YBY
rm -rf $OUTPUT_TRAIN_POOLNET_YWX
rm -rf $OUTPUT_TRAIN_POOLNET_YWY

rm -rf $OUTPUT_TRAIN_POOLNET_GRAY_XGX
rm -rf $OUTPUT_TRAIN_POOLNET_GRAY_XGY
rm -rf $OUTPUT_TRAIN_POOLNET_GRAY_YGX
rm -rf $OUTPUT_TRAIN_POOLNET_GRAY_YGY

# replicates input directory structure
rsync -a --include '*/' --exclude '*' "$PRED_TRAIN_POOLNET_X" "$OUTPUT_TRAIN_POOLNET_X"
rsync -a --include '*/' --exclude '*' "$PRED_TRAIN_POOLNET_Y" "$OUTPUT_TRAIN_POOLNET_Y"

echo "Network: PoolNet | Grey as: Negative | Train: x | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_XBX -o $OUTPUT_TRAIN_POOLNET_XBX -m iogt -c bw
echo "Network: PoolNet | Grey as: Negative | Train: x | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_XBY -o $OUTPUT_TRAIN_POOLNET_XBY -m iogt -c bw
echo "Network: PoolNet | Grey as: Positive | Train: x | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_XWX -o $OUTPUT_TRAIN_POOLNET_XWX -m iogt -c bw
echo "Network: PoolNet | Grey as: Positive | Train: x | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_XWY -o $OUTPUT_TRAIN_POOLNET_XWY -m iogt -c bw
echo "Network: PoolNet | Grey as: Negative | Train: y | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_YBX -o $OUTPUT_TRAIN_POOLNET_YBX -m iogt -c bw
echo "Network: PoolNet | Grey as: Negative | Train: y | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_YBY -o $OUTPUT_TRAIN_POOLNET_YBY -m iogt -c bw
echo "Network: PoolNet | Grey as: Positive | Train: y | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_YWX -o $OUTPUT_TRAIN_POOLNET_YWX -m iogt -c bw
echo "Network: PoolNet | Grey as: Positive | Train: y | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_YWY -o $OUTPUT_TRAIN_POOLNET_YWY -m iogt -c bw



echo "Network: PoolNet-Gray | Grey as: Negative | Train: x | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_GRAY_XGX -o $OUTPUT_TRAIN_POOLNET_GRAY_XGX -m iogt -c bw
echo "Network: PoolNet-Gray | Grey as: Negative | Train: x | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_GRAY_XGY -o $OUTPUT_TRAIN_POOLNET_GRAY_XGY -m iogt -c bw
echo "Network: PoolNet-Gray | Grey as: Positive | Train: x | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_GRAY_XGX -o $OUTPUT_TRAIN_POOLNET_GRAY_XGX -m iogt -c bw
echo "Network: PoolNet-Gray | Grey as: Positive | Train: x | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_GRAY_XGY -o $OUTPUT_TRAIN_POOLNET_GRAY_XGY -m iogt -c bw
echo "Network: PoolNet-Gray | Grey as: Negative | Train: y | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_GRAY_YGX -o $OUTPUT_TRAIN_POOLNET_GRAY_YGX -m iogt -c bw
echo "Network: PoolNet-Gray | Grey as: Negative | Train: y | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_GRAY_YGY -o $OUTPUT_TRAIN_POOLNET_GRAY_YGY -m iogt -c bw
echo "Network: PoolNet-Gray | Grey as: Positive | Train: y | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_GRAY_YGX -o $OUTPUT_TRAIN_POOLNET_GRAY_YGX -m iogt -c bw
echo "Network: PoolNet-Gray | Grey as: Positive | Train: y | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_GRAY_YGY -o $OUTPUT_TRAIN_POOLNET_GRAY_YGY -m iogt -c bw
