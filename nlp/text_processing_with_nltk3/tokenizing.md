# Tokenizing Text and WordNet Basics

## Overview

NLTK is originally designed for **teaching**, it has been adopted in the industry for research and development due to its usefulness and breadth of coverage. It's often used for **rapid prototyping** of text processing programs and can even be used in production applications.

Demos of select NLTK functionality and production-ready APIs are available at [text-processing.com](http://text-processing.com)

**Tokenization** is a method of breaking up a piece of text into many pieces, such as sentences and words, and is an **essential first step** for recipes in other NLP tasks.

**WordNet** is a dict designed for programmatic access by NLP systems, it has different use cases:

* Looking up the definition of a word
* Finding synonyms an antonyms
* Exploring word relations and similarity
* Word sense disambiguation

## Tokenizing text into sentences

```python
from nltk.tokenize import sent_tokenize

para = "Hello world. It's good to see you. Thanks for giving me this. I will go to U.S.A. next week."
print(sent_tokenize(para))
```

The ```sent_tokenize``` func uses an instance of ```PunktSentenceTokenizer``` from the nltk.tokenize.punkt module. This instance has already been **trained and works well for many European languages**.

We can also load a sentence tokenizer manually:

```python
import nltk.data
tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')
print(tokenizer.tokenize(para))
```

## Tokenizing sentence into words

```python
from nltk.tokenize import word_tokenize

print(word_tokenize('Hello NLTK.'))
```

```word_tokenize``` is a wrapper function that calls ```tokenize()``` on an instance of ```TreebankWordTokenizer``` class, it's equivalent to the following code:

```python
from nltk.tokenize import TreebankWordTokenizer

tokenizer = TreebankWordTokenizer()
print(tokenizer.tokenize('Hello NLTK.'))
```

It works by separating words using spaces and punctuation. There are two other word tokenizers worth looking at: ```PunktWordTokenizer``` and ```WordPunktTokenizer```, these differ from ```TreebankWordTokenizer``` by how they handle **punctuation and contractions**, but they all inherit from ```TokenizerI```.

## Tokenizing sentences using regular exp

The ```RegexpTokenizer``` class works by compiling your pattern, then calling ```re.findall``` on your text.

## Training a sentence tokenizer

Also use ```PunktSentenceTokenizer```.

## Filtering stopwords in a tokenized sentence

**Stopwords** are common words that generally do not contribute to the meaning of a sentence, at least for the purposes of info retrieval and NLP. These are words such as *the* and *a*.

NLTK comes with a **stopwords** corpus that contains word lists for many languages.

The **stopwords** corpus is an instance of ```nltk.corpus.reader.WordListCorpusReader```. 
