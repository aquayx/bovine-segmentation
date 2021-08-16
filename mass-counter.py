from PIL import Image
import numpy as np
import os, fnmatch
from skimage.measure import label, regionprops

from natsort import natsorted  # sorts numbers "naturally" lol


def get_files(dir):
    list_files = []
    for root, dirnames, filenames in os.walk(dir):
        for filename in fnmatch.filter(filenames, '*.[Pp][Nn][Gg]'):  # case insensitive with regards to the file extension
            list_files.append(os.path.join(root, filename))
    return natsorted(list_files)

def open_and_count(img_path):  # bw only (1-bit)
    img = label(np.array(Image.open(img_path).convert('1')), background=1)
    return len(regionprops(np.array(img)))

list1 = get_files('./_testing-sample/annotation')
list2 = get_files('./_testing-sample/discretized-50')

f = open('count.txt', 'w')
f.write('filename |  gt  | model\n')

for i in range(len(list1)):  # hope the two lists have the same length
    n_regions1 = open_and_count(list1[i])
    n_regions2 = open_and_count(list2[i])
    
    strwrite = '%8s | %4d %5d' % (list1[i].split('\\')[-1], n_regions1, n_regions2)
    f.write(strwrite + '\n')

f.close()
