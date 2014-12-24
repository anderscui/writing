import numpy as np
from sklearn.datasets import load_iris
from matplotlib import pyplot as plt

data = load_iris()
features = data['data']

print(features.ndim, features.shape)
# (2, (150L, 4L))

features_names = data['feature_names']
print(features_names)

target = data['target']
# print(target.ndim, target.shape)
# (1, (150L,))


# print(target == 0,0)
# print(target == 0,1)
# print(features)
# print(features[target == 0, 0])
# print(features[target == 0, 1])

# all possible pairs (combinations)
pairs = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]
for i, (p0, p1) in enumerate(pairs):
    # draw 2 * 3 sub plots
    plt.subplot(2, 3, i + 1)

    # draw 3 classes
    for t, marker, c in zip(xrange(3), '>ox', 'rgb'):
        #print(t, marker, c)
        plt.scatter(features[target == t, p0],
                    features[target == t, p1],
                    marker=marker,
                    c=c)
    plt.xlabel(features_names[p0])
    plt.ylabel(features_names[p1])
    plt.xticks([])
    plt.yticks([])

#plt.show()

plt.savefig('output/02_01.png')