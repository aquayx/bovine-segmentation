#!/bin/bash
# runs testing by pixel-based metric for all predictions
GT_BX="./gts/b/x/"
GT_BY="./gts/b/y/"
GT_WX="./gts/w/x/"
GT_WY="./gts/w/y/"
PRED_TRAIN_UNET_X="./wshed_cnn/unet/train_x/"
PRED_TRAIN_UNET_Y="./wshed_cnn/unet/train_y/"
OUTPUT_TRAIN_UNET_X="./results/pixel/unet_wshed/train_x/"
OUTPUT_TRAIN_UNET_Y="./results/pixel/unet_wshed/train_y/"
PRED_TRAIN_UNET_XBX="./wshed_cnn/unet/train_x/b/x/"
PRED_TRAIN_UNET_XBY="./wshed_cnn/unet/train_x/b/y/"
PRED_TRAIN_UNET_XWX="./wshed_cnn/unet/train_x/w/x/"
PRED_TRAIN_UNET_XWY="./wshed_cnn/unet/train_x/w/y/"
PRED_TRAIN_UNET_YBX="./wshed_cnn/unet/train_y/b/x/"
PRED_TRAIN_UNET_YBY="./wshed_cnn/unet/train_y/b/y/"
PRED_TRAIN_UNET_YWX="./wshed_cnn/unet/train_y/w/x/"
PRED_TRAIN_UNET_YWY="./wshed_cnn/unet/train_y/w/y/"
OUTPUT_TRAIN_UNET_XBX="./results/pixel/unet_wshed/train_x/b/x/"
OUTPUT_TRAIN_UNET_XBY="./results/pixel/unet_wshed/train_x/b/y/"
OUTPUT_TRAIN_UNET_XWX="./results/pixel/unet_wshed/train_x/w/x/"
OUTPUT_TRAIN_UNET_XWY="./results/pixel/unet_wshed/train_x/w/y/"
OUTPUT_TRAIN_UNET_YBX="./results/pixel/unet_wshed/train_y/b/x/"
OUTPUT_TRAIN_UNET_YBY="./results/pixel/unet_wshed/train_y/b/y/"
OUTPUT_TRAIN_UNET_YWX="./results/pixel/unet_wshed/train_y/w/x/"
OUTPUT_TRAIN_UNET_YWY="./results/pixel/unet_wshed/train_y/w/y/"

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

echo "Network: U-net -> Watershed | Grey as: Negative | Train: x | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_UNET_XBX -o $OUTPUT_TRAIN_UNET_XBX -m pixel
echo "Network: U-net -> Watershed | Grey as: Negative | Train: x | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_UNET_XBY -o $OUTPUT_TRAIN_UNET_XBY -m pixel
echo "Network: U-net -> Watershed | Grey as: Positive | Train: x | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_UNET_XWX -o $OUTPUT_TRAIN_UNET_XWX -m pixel
echo "Network: U-net -> Watershed | Grey as: Positive | Train: x | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_UNET_XWY -o $OUTPUT_TRAIN_UNET_XWY -m pixel
echo "Network: U-net -> Watershed | Grey as: Negative | Train: y | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_UNET_YBX -o $OUTPUT_TRAIN_UNET_YBX -m pixel
echo "Network: U-net -> Watershed | Grey as: Negative | Train: y | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_UNET_YBY -o $OUTPUT_TRAIN_UNET_YBY -m pixel
echo "Network: U-net -> Watershed | Grey as: Positive | Train: y | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_UNET_YWX -o $OUTPUT_TRAIN_UNET_YWX -m pixel
echo "Network: U-net -> Watershed | Grey as: Positive | Train: y | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_UNET_YWY -o $OUTPUT_TRAIN_UNET_YWY -m pixel


PRED_TRAIN_POOLNET_X="./wshed_cnn/poolnet/train_x/"
PRED_TRAIN_POOLNET_Y="./wshed_cnn/poolnet/train_y/"
OUTPUT_TRAIN_POOLNET_X="./results/pixel/poolnet_wshed/train_x/"
OUTPUT_TRAIN_POOLNET_Y="./results/pixel/poolnet_wshed/train_y/"
PRED_TRAIN_POOLNET_XBX="./wshed_cnn/poolnet/train_x/b/x/"
PRED_TRAIN_POOLNET_XBY="./wshed_cnn/poolnet/train_x/b/y/"
PRED_TRAIN_POOLNET_XWX="./wshed_cnn/poolnet/train_x/w/x/"
PRED_TRAIN_POOLNET_XWY="./wshed_cnn/poolnet/train_x/w/y/"
PRED_TRAIN_POOLNET_YBX="./wshed_cnn/poolnet/train_y/b/x/"
PRED_TRAIN_POOLNET_YBY="./wshed_cnn/poolnet/train_y/b/y/"
PRED_TRAIN_POOLNET_YWX="./wshed_cnn/poolnet/train_y/w/x/"
PRED_TRAIN_POOLNET_YWY="./wshed_cnn/poolnet/train_y/w/y/"
OUTPUT_TRAIN_POOLNET_XBX="./results/pixel/poolnet_wshed/train_x/b/x/"
OUTPUT_TRAIN_POOLNET_XBY="./results/pixel/poolnet_wshed/train_x/b/y/"
OUTPUT_TRAIN_POOLNET_XWX="./results/pixel/poolnet_wshed/train_x/w/x/"
OUTPUT_TRAIN_POOLNET_XWY="./results/pixel/poolnet_wshed/train_x/w/y/"
OUTPUT_TRAIN_POOLNET_YBX="./results/pixel/poolnet_wshed/train_y/b/x/"
OUTPUT_TRAIN_POOLNET_YBY="./results/pixel/poolnet_wshed/train_y/b/y/"
OUTPUT_TRAIN_POOLNET_YWX="./results/pixel/poolnet_wshed/train_y/w/x/"
OUTPUT_TRAIN_POOLNET_YWY="./results/pixel/poolnet_wshed/train_y/w/y/"

PRED_TRAIN_POOLNET_GRAY_XGX="./wshed_cnn/poolnet/train_x/g/x/"
PRED_TRAIN_POOLNET_GRAY_XGY="./wshed_cnn/poolnet/train_x/g/y/"
PRED_TRAIN_POOLNET_GRAY_YGX="./wshed_cnn/poolnet/train_y/g/x/"
PRED_TRAIN_POOLNET_GRAY_YGY="./wshed_cnn/poolnet/train_y/g/y/"
OUTPUT_TRAIN_POOLNET_GRAY_XGX="./results/pixel/poolnet_wshed/train_x/g/x/"
OUTPUT_TRAIN_POOLNET_GRAY_XGY="./results/pixel/poolnet_wshed/train_x/g/y/"
OUTPUT_TRAIN_POOLNET_GRAY_YGX="./results/pixel/poolnet_wshed/train_y/g/x/"
OUTPUT_TRAIN_POOLNET_GRAY_YGY="./results/pixel/poolnet_wshed/train_y/g/y/"

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

echo "Network: PoolNet -> Watershed | Grey as: Negative | Train: x | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_XBX -o $OUTPUT_TRAIN_POOLNET_XBX -m pixel
echo "Network: PoolNet -> Watershed | Grey as: Negative | Train: x | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_XBY -o $OUTPUT_TRAIN_POOLNET_XBY -m pixel
echo "Network: PoolNet -> Watershed | Grey as: Positive | Train: x | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_XWX -o $OUTPUT_TRAIN_POOLNET_XWX -m pixel
echo "Network: PoolNet -> Watershed | Grey as: Positive | Train: x | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_XWY -o $OUTPUT_TRAIN_POOLNET_XWY -m pixel
echo "Network: PoolNet -> Watershed | Grey as: Negative | Train: y | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_YBX -o $OUTPUT_TRAIN_POOLNET_YBX -m pixel
echo "Network: PoolNet -> Watershed | Grey as: Negative | Train: y | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_YBY -o $OUTPUT_TRAIN_POOLNET_YBY -m pixel
echo "Network: PoolNet -> Watershed | Grey as: Positive | Train: y | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_YWX -o $OUTPUT_TRAIN_POOLNET_YWX -m pixel
echo "Network: PoolNet -> Watershed | Grey as: Positive | Train: y | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_YWY -o $OUTPUT_TRAIN_POOLNET_YWY -m pixel



echo "Network: PoolNet-Gray -> Watershed | Grey as: Negative | Train: x | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_GRAY_XGX -o $OUTPUT_TRAIN_POOLNET_GRAY_XGX -m pixel
echo "Network: PoolNet-Gray -> Watershed | Grey as: Negative | Train: x | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_GRAY_XGY -o $OUTPUT_TRAIN_POOLNET_GRAY_XGY -m pixel
echo "Network: PoolNet-Gray -> Watershed | Grey as: Positive | Train: x | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_GRAY_XGX -o $OUTPUT_TRAIN_POOLNET_GRAY_XGX -m pixel
echo "Network: PoolNet-Gray -> Watershed | Grey as: Positive | Train: x | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_GRAY_XGY -o $OUTPUT_TRAIN_POOLNET_GRAY_XGY -m pixel
echo "Network: PoolNet-Gray -> Watershed | Grey as: Negative | Train: y | Test: x"
python3 mass_metrics.py -g $GT_BX -p $PRED_TRAIN_POOLNET_GRAY_YGX -o $OUTPUT_TRAIN_POOLNET_GRAY_YGX -m pixel
echo "Network: PoolNet-Gray -> Watershed | Grey as: Negative | Train: y | Test: y"
python3 mass_metrics.py -g $GT_BY -p $PRED_TRAIN_POOLNET_GRAY_YGY -o $OUTPUT_TRAIN_POOLNET_GRAY_YGY -m pixel
echo "Network: PoolNet-Gray -> Watershed | Grey as: Positive | Train: y | Test: x"
python3 mass_metrics.py -g $GT_WX -p $PRED_TRAIN_POOLNET_GRAY_YGX -o $OUTPUT_TRAIN_POOLNET_GRAY_YGX -m pixel
echo "Network: PoolNet-Gray -> Watershed | Grey as: Positive | Train: y | Test: y"
python3 mass_metrics.py -g $GT_WY -p $PRED_TRAIN_POOLNET_GRAY_YGY -o $OUTPUT_TRAIN_POOLNET_GRAY_YGY -m pixel
