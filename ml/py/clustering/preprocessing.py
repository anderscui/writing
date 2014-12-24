import numpy as np
from sklearn.feature_extraction.text import CountVectorizer

# min_df determines how CountVectorizer treats a document frequency strictly lower than the given threshold
# token_pattern=(?u)\b\w\w+\b: this is the def of tokens
# so bag-of-words is split into bag, of and words.
vectorizer = CountVectorizer(min_df=1)
# print(vectorizer)

content = ['how to format my hard disk', 'Hard disk format problems.']
X = vectorizer.fit_transform(content)
# X is in sparse matrix format
print(X)
print(X.toarray())
#print(X.toarray().transpose())

print(vectorizer.get_feature_names())
# [u'disk', u'format', u'hard', u'how', u'my', u'problems', u'to']

