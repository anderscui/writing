from sys import path
import numpy as np
import matplotlib.pyplot as plt

from gensim import corpora, models, similarities

# if not path.exists('./data/ap/ap.dat'):
#     print('Error: Expected data to be present at data/ap/')

# corpus is just the preloaded list of words
corpus = corpora.BleiCorpus('./data/ap/ap.dat', './data/ap/vocab.txt')
model = models.LdaModel(corpus, num_topics=100, id2word=corpus.id2word)

topics = [model[c] for c in corpus]
print(topics[0])
print(len(topics))

thetas = [model[c] for c in corpus]
print(len(thetas))
plt.hist([len(t) for t in thetas], np.arange(42))
plt.ylabel('Nr of documents')
plt.xlabel('Nr of topics')
plt.savefig('./1400OS_04_01.png')

# for ti in xrange(84):
#     words = model.show_topic(ti, 64)
#     tf = sum(f for f, w in words)
#     print('\n'.join('{}:{}'.format(w, int(1000. * f / tf)) for f, w in words))
#     print()
#     print()
#     print()