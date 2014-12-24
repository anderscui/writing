import numpy as np
from matplotlib import pyplot as plt
from sklearn.datasets import load_iris
from threshold import learn_model, accuracy

data = load_iris()
features = data['data']
labels = data['target_names'][data['target']]

non_setosa = (labels != 'setosa')
features = features[non_setosa]
labels = labels[non_setosa]
virginica = (labels == 'virginica')

# half train, half test
testing = np.tile([True, False], features.shape[0] / 2)
# print(type(testing))
# print(len(testing))
# print(testing)
training = ~testing

# training error is always an overly optimistic estimation,
# so we should always measure and report the testing error.
model = learn_model(features[training], virginica[training])
train_error = accuracy(features[training], virginica[training], model)
test_error = accuracy(features[testing], virginica[testing], model)

print('''\
Training error was {0:.1%}.
Testing error was {1:.1%} (N = {2}).
'''.format(train_error, test_error, testing.sum()))
