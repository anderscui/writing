# from sklearn import tree
#
# X = [[0, 0], [1, 1]]
# Y = [0, 1]
# clf = tree.DecisionTreeClassifier()
# clf = clf.fit(X, Y)
# print(clf)
#
# print(clf.predict([[2., 2.]]))

print('-- iris dataset --')

from sklearn.datasets import load_iris
from sklearn import tree

iris = load_iris()
clf = tree.DecisionTreeClassifier()
clf = clf.fit(iris.data, iris.target)

# from sklearn.externals.six import StringIO
# with open('iris.dot', 'w') as f:
#     f = tree.export_graphviz(clf, out_file=f)
#
# import os
# os.unlink('iris.dot')

# from sklearn.externals.six import StringIO
# import pydot
# dot_data = StringIO()
# tree.export_graphviz(clf, out_file=dot_data)
# graph = pydot.graph_from_dot_data(dot_data.getvalue())
# graph.write_pdf('iris.pdf')

print(clf.predict(iris.data[0, :]))
