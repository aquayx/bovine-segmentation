import file_handling
import numpy as np
from PIL import Image

IMG_SIZE = 512

def paste(raw, gt, iogtx, iogty, predx, predy):
    nw = Image.new('RGB', (IMG_SIZE*3, IMG_SIZE*2), color=(0, 0, 0))
    # rawn = raw.resize((IMG_SIZE,IMG_SIZE))
    nw.paste(raw, box=(0, 0))
    nw.paste(gt, box=(0, IMG_SIZE))
    nw.paste(iogtx, box=(IMG_SIZE, 0))
    nw.paste(predx, box=(IMG_SIZE, IMG_SIZE))
    nw.paste(iogty, box=(IMG_SIZE*2, 0))
    nw.paste(predy, box=(IMG_SIZE*2, IMG_SIZE))
    return nw

#raw, im, gt, pred = img_gt_pred('./data')
imglist_gts = file_handling.get_list_of_files('./gt-grey')
gt = file_handling.get_imgs_from_filelist(imglist_gts, type='color', pil_format=True)

raw = file_handling.get_imgs_from_filelist(file_handling.get_imglist_from_gt_list(imglist_gts, './img'), type='color', pil_format=True)
iogtx = file_handling.get_imgs_from_filelist(file_handling.get_imglist_from_gt_list(imglist_gts, './dst/x_grey_3000'), type='color', pil_format=True)
iogty = file_handling.get_imgs_from_filelist(file_handling.get_imglist_from_gt_list(imglist_gts, './dst/y_grey_3000'), type='color', pil_format=True)
predx = file_handling.get_imgs_from_filelist(file_handling.get_imglist_from_gt_list(imglist_gts, './norm/x_grey_3000'), type='color', pil_format=True)
predy = file_handling.get_imgs_from_filelist(file_handling.get_imglist_from_gt_list(imglist_gts, './norm/y_grey_3000'), type='color', pil_format=True)

# gt = [Image.open(x) for x in natsorted(glob("./mini/gt/*"))]
# raw = [Image.open(x) for x in natsorted(glob("./mini/raw/*"))]
# iogtx = [Image.open(x) for x in natsorted(glob("./mini/iogt/bl/x/*"))]
# iogty = [Image.open(x) for x in natsorted(glob("./mini/iogt/bl/y/*"))]
# predx = [Image.open(x) for x in natsorted(glob("./mini/res0/xxy/*"))]
# predy = [Image.open(x) for x in natsorted(glob("./mini/res0/yyx/*"))]

nws = []
for i in range(len(raw)):
    nws.append(paste(raw[i], gt[i], iogtx[i], iogty[i], predx[i], predy[i]))
    nws[-1].save('./_blend/{:02d}.png'.format(i))

'''
iogtx = [Image.open(x) for x in natsorted(glob("./mini/iogt/wh/x/*"))]
iogty = [Image.open(x) for x in natsorted(glob("./mini/iogt/wh/y/*"))]
predx = [Image.open(x) for x in natsorted(glob("./mini/res1/xxy/*"))]
predy = [Image.open(x) for x in natsorted(glob("./mini/res1/yyx/*"))]

nws = []
for i in range(len(raw)):
    nws.append(paste(raw[i], gt[i], iogtx[i], iogty[i], predx[i], predy[i]))
    nws[-1].save('./data/blend/wh/{:02d}.png'.format(i))
'''
