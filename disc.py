from PIL import Image
from glob import glob
from natsort import natsorted
from itertools import product
from skimage.measure import label, regionprops
from file_handling import *
import numpy as np

import cv2

def inner(regions, pred, lim, top=1, low=0):
    pred_bin = binarize(pred, lim)
    pred_label = label(pred_bin, background=1)
    pred_props = len(regionprops(pred_label))
    if lim < 0.25:
        return 0.25, pred_props
    if low >= top:
        return lim, pred_props
    delta = pred_props - regions
    if -7 <= delta <= 7:
        return lim, pred_props
    elif delta > 7:
        return inner(regions, pred, (top + lim)/2, top, top/2)
    elif delta < 7:
        return inner(regions, pred, lim/2, top/2, low)

def find_lim(gt, pred, lim=0.5):
    gt_label = label(gt, background=1)
    gt_props = len(regionprops(gt_label))
    return *inner(gt_props, pred, lim), gt_props

# Sets every label pixel value to 1 if probability is higher than given threshold, zero otherwise.
def binarize(img, thrsh):
    new = np.ndarray(img.shape)
    factor = 255*thrsh
    for i, j in product(range(img.shape[0]), range(img.shape[1])):
        if img[i, j][0] >= factor:
            new[i, j] = 255
        else:
            new[i, j] = 0
    return new

def binarize_all(gts, preds):
    bins = []
    for i in range(len(gts)):
        th, a, b = find_lim(gts[i], preds[i])
        bins.append(binarize(preds[i], th))
        print(i, th)
    return bins


srcs_pr = ['./norm']
src_gt = './gt-wh/x'
dsts = ['./disc']

files_gt = natsorted(glob("{}/*".format(src_gt)))
ims_gt = [replace_grey_pixels(np.array(Image.open(x).convert('L')), whiten=False) for x in files_gt]

for src_pr, dst in zip(srcs_pr, dsts):
    files_pr = natsorted(glob("{}/*".format(src_pr)))
    ims_pr = [np.array(Image.open(x)) for x in files_pr]
    print(files_pr)
    bins = binarize_all(ims_gt, ims_pr)
    for idx in range(len(bins)):
        cv2.imwrite(dst + "/" + str(idx) + ".png", bins[idx])
