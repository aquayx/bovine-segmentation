def split_modelname(modelname):
    if 'on' in modelname:
        name = modelname.split('on')[0].strip()
        grey = modelname.split('on')[-1].strip()
    else:
        name = modelname[:modelname.rfind('\_')]
        grey = modelname[modelname.rfind('\_')+2:]
    if grey == 'Neg':
        grey = 'Negative'
    if grey == 'Pos':
        grey = 'Positive'
    return name, grey

def latexify_line(model, grey_as, result_class, xx, xy, yx, yy):
    print('%s & %s & %s & %.2f\%% & %.2f\%% & %.2f\%% & %.2f\%%  \\\\' % (model, grey_as, result_class, xx, xy, yx, yy))

def latexify_ws_line(model, grey_as, result_class, x, y):
    print('%s & %s & %s & \multicolumn{2}{c|}{Test on X: %.2f\%%} & \multicolumn{2}{c}{Test on Y: %.2f\%%}  \\\\' % (model, grey_as, result_class, x, y))

def underline(str1, str2):
    return str1 + '\_' + str2

def keygen(model, grey_as):
    if 'Grey' in model:
        key = model + ' on ' + grey_as
    else:
        key = underline(model, grey_as)
    return key



results = {}

models = ['U-net', 'PoolNet', 'PoolNet-Grey', 'Watershed', underline('U-net', 'WS'), underline('PoolNet', 'WS'), underline('PoolNet-Grey', 'WS')]
grey_as = ['Neg', 'Pos']

# initialize dict
for i in models:
    for j in grey_as:
        key = keygen(i,j)
        results[key] = {'Good':{}, 'Over':{}, 'Under':{}}

input = open('test-results', 'r')
for i in input:
    if i.split(':')[0] == 'Model':  # expected line format:  Model: U-net | Grey as: Negative | Train: x | Test: x
        model = i.split(':')[1].split('|')[0].strip()  # model name
        grey_as = i.split(':')[2].split('|')[0].strip()[0:3]  # grey as (positive or negative), shortened to 3 characters
        train = i.split(':')[3].split('|')[0].strip()  # trained on
        test = i.split(':')[4].strip()  # tested on
    if i.split(':')[0] == 'Good':   # expected line format:  good: 85.32 | over: 0.25 | under: 14.43
        results[keygen(model, grey_as)][i.split(':')[0]][train+test] = float(i.split(':')[1].split('|')[0].strip())
        results[keygen(model, grey_as)][i.split(':')[1].split('|')[1].strip()][train+test] = float(i.split(':')[2].split('|')[0].strip())
        results[keygen(model, grey_as)][i.split(':')[2].split('|')[1].strip()][train+test] = float(i.split(':')[3].strip())

for i in results:
    for j in results[i]:
        name, grey = split_modelname(i)
        if 'Watershed' in name:
            latexify_ws_line(name, grey, j, results[i][j]['x'], results[i][j]['y'])
        else:
            latexify_line(name, grey, j, results[i][j]['xx'], results[i][j]['xy'], results[i][j]['yx'], results[i][j]['yy'])
    print('\hline')
