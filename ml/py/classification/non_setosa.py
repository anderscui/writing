import numpy as np
from sklearn.datasets import load_iris
from threshold import learn_model, accuracy

data = load_iris()
features = data['data']
target_names = data['target_names']
labels = target_names[data['target']]

non_setosa = (labels != 'setosa')
features = features[non_setosa]
print(features.shape[0], features.shape[1])

labels = labels[non_setosa]
virginica = (labels == 'virginica')
# print(virginica)

features_names = data['feature_names']
print("features:", features_names)

# threshold and index
t, fi = learn_model(features, virginica)
print('model: feature - {0}, threshold - {1}'.format(features_names[fi], t))
print('accuracy: {0}%'.format(accuracy(features, virginica, (t, fi)) * 100))

