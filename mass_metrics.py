import argparse
import numpy
from skimage.measure import label, regionprops

import file_handling
import morph
import tools
import region_matching

parser = argparse.ArgumentParser()
parser.add_argument("-g", "--groundtruths", default='gts/b/x')
parser.add_argument("-p", "--predictions", default='bin/unet/train_x/b/x')
parser.add_argument("-o", "--output", default='results/iogt')
parser.add_argument("-m", "--metric", default='iogt')
parser.add_argument("-c", "--color", default='gray')
parser.add_argument("-d", "--depth", default=-1, type=int)
parser.add_argument("-a", "--arguments", nargs='*')
parser.add_argument("-v", "--verbose", default=0, type=int)
args = parser.parse_args()

# readability
dir_gts = args.groundtruths
dir_preds = args.predictions
metric = args.metric
color_level = args.color
dir_output = args.output
depth = args.depth
arguments = args.arguments
verbose = False if args.verbose == 0 else True


def mass_metric(dir_gts, dir_preds, dir_output, metric, color_level='gray', depth=-1, arguments=None, verbose=False):
    filelist_gts = file_handling.get_list_of_files(dir_gts)
    filelist_preds = file_handling.get_list_of_files(dir_preds)
    images_gts = file_handling.get_imgs_from_filelist(filelist_gts, color_level=color_level)
    images_preds = file_handling.get_imgs_from_filelist(filelist_preds, color_level=color_level)
    images_results = []

    if len(images_gts) != len(images_preds):
        print("WARNING: amount of images_gts is different from amount of images_preds (%d != %d)" % (len(images_gts), len(images_preds)))

    if metric == 'pixel':
        results = [0, 0, 0, 0]
        for img_gt, img_pred in zip(images_gts, images_preds):
            blend, img_results = tools.blend_matching(img_gt, img_pred)
            images_results.append(blend)
            results = [x + y for x, y in zip(results, img_results)]
        results = [x/len(images_gts) for x in results]
        print("accuracy: %.2f | precision: %.2f | recall: %.2f | f1: %.2f" % (results[0]*100, results[1]*100, results[2]*100, results[3]*100))

    if metric == 'iogt':
        results = [0, 0, 0]
        data = {'total': [], 'over': [], 'under': [], 'good': []}
        for img_gt, img_pred in zip(images_gts, images_preds):
            gtlab = label(numpy.array(img_gt), background=1)
            pred_label = label(numpy.array(img_pred), background=1)
            props_gts = tools.get_props_from_img(img_gt)
            props_preds = tools.get_props_from_img(img_pred)

            region_associations = [x for x in region_matching.reg_match(gtlab, pred_label, props_gts, props_preds)]
            region_associations_1 = [x for x in region_matching.reg_match(pred_label, gtlab, props_preds, props_gts)]

            verdicts, tot, ov, und, good = tools.verdicts_iou(region_associations, region_associations_1, props_gts, props_preds, print_results=0)

            verdict_image = tools.paint_verdicts(region_associations, verdicts, props_gts, img_gt)
            verdict_image = tools.paint_borders(verdict_image, numpy.array(img_gt), numpy.array(img_pred))

            images_results.append(numpy.array(verdict_image))

            data['total'].append(tot)
            data['over'].append(ov)
            data['under'].append(und)
            data['good'].append(good)
        results = [sum(data['good'])/sum(data['total']), sum(data['under'])/sum(data['total']), sum(data['over'])/sum(data['total'])]
        print("good: %.2f | over: %.2f | under: %.2f" % (results[0]*100, results[2]*100, results[1]*100))

    file_handling.save_list_of_image_objects(filelist_preds, images_results, dir_output, depth, verbose)

mass_metric(dir_gts, dir_preds, dir_output, metric, color_level, depth, arguments, verbose)
