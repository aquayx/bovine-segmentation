import argparse

import file_handling
import morph
import tools

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", default='gts/_gt-skel')
parser.add_argument("-o", "--output", default='_dilate_output_test')
parser.add_argument("-t", "--technique", default='dilate')
parser.add_argument("-c", "--color", default='gray')
parser.add_argument("-r", "--replace", default='no')
parser.add_argument("-d", "--depth", default=-1, type=int)
parser.add_argument("-a", "--arguments", nargs='*')
parser.add_argument("-v", "--verbose", default=0, type=int)
args = parser.parse_args()

# readability
dir_input = args.input
dir_output = args.output
technique = args.technique
color_level = args.color
replace = args.replace
depth = args.depth
arguments = args.arguments
verbose = False if args.verbose == 0 else True

def mass_operation(input, output, technique, color_level='color', replace='no', depth=-1, arguments=None, verbose=False):
    filelist = file_handling.get_list_of_files(dir_input)
    image_objects = file_handling.get_imgs_from_filelist(filelist, color_level=color_level, replace=replace)
    if technique == 'norm':
        for index, img in enumerate(image_objects):
            image_objects[index] = tools.normalize(img)
    if technique == 'dilate':
        for index, img in enumerate(image_objects):
            image_objects[index] = morph.morph(img, operation='dilate', levels=int(arguments[0]))
    if technique == 'skel_dilate':
        for index, img in enumerate(image_objects):
            image_objects[index] = morph.morph(img, operation='skel_dilate', levels=int(arguments[0]))
    if technique == 'bin':
        for index, img in enumerate(image_objects):
            image_objects[index] = tools.binarize(img, method=arguments[0], param=int(arguments[1]) if len(arguments) > 1 else 0)
    if technique == 'fix':
        for index, img in enumerate(image_objects):
            image_objects[index] = tools.fix_gt_artifacts(img)
    if technique == 'watershed':
        for index, img in enumerate(image_objects):
            image_objects[index] = tools.watershed(img, raw=True if arguments is not None else False)  # TODO: probably should edit this line to accept more arguments. see tools.watershed
    file_handling.save_list_of_image_objects(filelist, image_objects, dir_output, depth, verbose)

mass_operation(dir_input, dir_output, technique, color_level, replace, depth, arguments, verbose)
