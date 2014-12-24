import numpy as np
from sklearn.datasets import load_iris

data = load_iris()
features = data['data']

# class names
target_names = data['target_names']
labels = target_names[data['target']]

print(target_names)

# petal length is the 3rd column.
plength = features[:, 2]
is_setosa = (labels == 'setosa')

# from the visualization, we know all(setosa.length) < any(others.length)
setosa_max = plength[is_setosa].max()
others_min = plength[~is_setosa].min()
print('Maximum of setosa: {0}.'.format(setosa_max))
print('Minimum of others: {0}.'.format(others_min))
# Maximum of setosa: 1.9.
# Minimum of others: 3.0.

# so we can build a simple model
if features[:, 2] < 2:
    print('Iris Setosa')
else:
    print('Iris Virginica or Iris Versicolour')

# index = [5 * w for w in xrange(20)]
#
# setosa_max += 0.1
# others_min -= 0.1
# for i in index:
#     if features[i, 2] < setosa_max:
#         print('Iris Setosa')
#     else:
#         print('Others')