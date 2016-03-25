# Creating Custom Corpora

We will cover how to use corpus readers and create custom corpora. If we want to train our own model, such as POS tagger or text classifier, we will need to create a custom corpus to train on.

We will also cover creating custom readers, which can be used when tghe corpus is not in a compatible format or not located in a database such as MongoDB.

## Setting up a custom corpus

A **corpus** is a collection of text documents, and **corpara** is the plural of corpus. This comes from the Latin word for body; in this case, a body of text.

NLTK defines a list of data directions, or paths, in ```nltk.data.path```. Our custom corpora must be within one of these paths. After that, loading a file is very simple:

```python
import nltk.data

print(nltk.data.load('corpora/cookbook/mywords.txt', format='raw'))
```

## Creating a wordlist corpus

The ```WordListCorpusReader``` class is one of the simplest ```CorpusReader``` classes. It provides access to a file containing a list of words, *one word per line*.

```python
from nltk.corpus.reader import WordListCorpusReader
import nltk

d = nltk.data.find('corpora/cookbook')
reader = WordListCorpusReader(d, ['wordlist.txt'])
print(reader.words())
print(reader.fileids())
```

The ```WordListCorpusReader``` class inheirts from ```CorpusReader```, which is a common base class for all corpus readers.

## Creating a POS tagged word corpus

POS tagging is the process of identifying the POS tag for a word. Most of the time, a tagger must first be trained on a training corpus.

The simplest format for a tagged corpus is of the form word/tag.

PS: Different corpora can use diff tags to mean the same thing.

```python
d = nltk.data.find('corpora/cookbook')
reader = TaggedCorpusReader(d, r'.*\.pos')
print(reader.words())
print(reader.tagged_words())
print(reader.sents())
print(reader.tagged_sents())
print(reader.paras())
print(reader.tagged_paras())
```

### Converting tags to a universal tagset

NLTK 3.0 provides a method for converting known tagsets to a universal tagset. The **universal tagset** is a simplified and condensed tagset composed of only 12 POS tags:

```python
reader = TaggedCorpusReader(d, r'.*\.pos', word_tokenizer=SpaceTokenizer(), tagset='en-brown')
print(reader.tagged_sents(tagset='universal'))
```

Most NLTK tagged corpora are initialized with a known tagset, making conversion easy:

## Creating a chunked phrase corpus

A **chunk** is a short phrase within a sentence.

```
[Earlier/JJR staff-reduction/NN moves/NNS] have/VBP trimmed/VBN about/IN [300/CD jobs/NNS] ,/, [the/DT spokesman/NN] said/VBD ./.
```

In this format, every chunk is a noun phrase. Words that not within brackets are part of the sentence tree, but are not part of any noun phrase subtree.

```python
d = nltk.data.find('corpora/cookbook')
reader = ChunkedCorpusReader(d, r'.*\.chunk')
print(reader.chunked_sents())
# all tokens
print(reader.chunked_sents()[0].leaves())
```

```
[Tree('S', [
    Tree('NP', [(u'Earlier', u'JJR'), (u'staff-reduction', u'NN'), (u'moves', u'NNS')]), 
    (u'have', u'VBP'), 
    (u'trimmed', u'VBN'), 
    (u'about', u'IN'), 
    Tree('NP', [(u'300', u'CD'), (u'jobs', u'NNS')]), 
    (u',', u','), 
    Tree('NP', [(u'the', u'DT'), (u'spokesman', u'NN')]), 
    (u'said', u'VBD'), 
    (u'.', u'.')
])]
```

Use the following method to draw a tree:

```python
reader.chunked_sents()[0].draw()
```

If you want to use the IOB format, use the ```ConllChunkCorpusReader``` class.

### Treebank chunk corpus

The ```nltk.corpus.treebank_chunk``` uses ```ChunkedCorpusReader``` to provide POS tagged words. NLTK comes with 5% sample from the Penn Treebank Project, find out [more](http://www.cis.upenn.edu/~treebank/home.html).

### CoNLL2000 corpus

**CoNLL** stands for the **Conference on Computational Natural Language Learning**. Check ```nltk.corpus.conll2000```, which is an instance of ```ConllChunkCorpusReader``` class, find out [more](http://www.cnts.ua.ac.be/conll2000/chunking/).

## Creating a categorized text corpus

If we have a large corpus of text, we might want to categorize it into separate sections. This can be useful for organization, or for **text classification**. The ```brown``` corpus, for example, has a number of different categories, as shown in the following code:

```python
from nltk.corpus import brown
print(brown.categories())
```

Now we will learn how to create our own categorized text corpus.

```python
from nltk.corpus.reader import CategorizedPlaintextCorpusReader
import nltk

d = nltk.data.find('corpora/cookbook')
reader = CategorizedPlaintextCorpusReader(d, r'movie_.*\.txt', cat_pattern=r'movie_(\w+)\.txt')
print(reader.categories())
print(reader.fileids(categories='neg'))
print(reader.fileids(categories='pos'))
```

## Lazy corpus loading

NLTK provides a ```LazyCorpusLoader``` class that can transform itself into your actual corpus reader as soon as you need it.

```python
from nltk.corpus.util import LazyCorpusLoader
from nltk.corpus.reader import WordListCorpusReader

reader = LazyCorpusLoader('cookbook', WordListCorpusReader, ['wordlist.txt'])
print(isinstance(reader, LazyCorpusLoader))  # True

print(reader.fileids())
print(isinstance(reader, LazyCorpusLoader))  # False
print(isinstance(reader, WordListCorpusReader))  # True
```

All of the corpura included with NLTK and defined in ```nltk.corpus``` are initially a ```LazyCorpusLoader``` class.

## Creating a custom corpus view

A **corpus view** is a class wrapper around a corpus file that reads in blocks of tokens as needed.

Useful when dealing with very large datasets.

TODO

## Creating a MongoDB-backed corpus reader

TODO

## Corpus editing with file locking

TODO
