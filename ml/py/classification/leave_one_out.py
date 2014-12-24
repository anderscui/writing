import numpy as np
from sklearn.datasets import load_iris
from threshold import learn_model, apply_model

data = load_iris()
features = data['data']
labels = data['target_names'][data['target']]

setosa = (labels == 'setosa')
features = features[~setosa]
labels = labels[~setosa]
virginica = (labels == 'virginica')

error = 0.0
for ei in xrange(len(features)):
    # select all but the one at position 'ei'
    training = np.ones(len(features), bool)
    training[ei] = False
    testing = ~training

    model = learn_model(features[training], virginica[training])
    predictions = apply_model(features[testing], model)
    error += np.sum(predictions != virginica[testing])

print(error)

# use X-fold CV
