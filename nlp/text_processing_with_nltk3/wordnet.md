# WordNet

**WordNet** is a lexical database for the English language, it's a dictionary designed specifically for NLP.

NLTK comes with a simple interface to lookup words in WordNet. What you get is a list of **Synset** instances, which are groupings of synonymous words that express the same concept.

## Looking up Synsets for a word in WordNet

We use ```WordNetCorpusReader``` to access ```wordnet``` corpus.

```python
from nltk.corpus import wordnet

# a single synset
syn = wordnet.synsets('cookbook')[0]
print(syn.name())
print(syn.definition())
```

Synsets are organized in a structure to that of an inheritance tree. More abstract terms are known as **hypernyms** and more specific terms are **hyponyms**.

POS:

```python
print(syn.pos())
```

There are four common POS tags found in WordNet:

* n - Noun
* a - Adj
* r - Adv
* v - Verb

## Looking up lemmas and synonyms in WordNet

A **lemma** is the canonical form or morphological form of a word.

```python
from nltk.corpus import wordnet

syn = wordnet.synsets('cookbook')[0]
lemmas = syn.lemmas()
print(len(lemmas))
print(lemmas[0].name())
print(lemmas[1].name())
print(lemmas[0].synset() == lemmas[1].synset())
```

cookery_book and cookbook are two distinct lemmas in the same Synset, a lemma can only belong to a single Synset. **A Synset represents a group of lemmas that all have the same meaning, while a lemma represents a distinct word form**.

So all the lemmas in a Synset can be treated as synonyms. And we can also get all possible synonyms:

```python
from nltk.corpus import wordnet

synonyms = []
for syn in wordnet.synsets('book'):
    for lemma in syn.lemmas():
        synonyms.append(lemma.name())
print(len(synonyms))
print(len(set(synonyms)))

print(set(synonyms))
```

## Calculating WordNet Synset similarity

Synsets are organized in a *hypernym* tree which can be used for reasoning about the similarity between the Synsets it contains.

```python
from nltk.corpus import wordnet

cb = wordnet.synset('cookbook.n.01')
ib = wordnet.synset('instruction_book.n.01')
print(cb.wup_similarity(ib))
```

The ```wup_similarity``` is short for **Wu-Palmer Similarity**, which is a scoring method based on how similar the word senses are and where the Synsets occur relative to each other in the hypernym tree.

## Discovering word collocations

**Collocations** are two or more words that tend to appear frequently together, such as United
States.

```BigramCollocationFinder``` constructs two frequency distributions: one for each word,
and another for bigrams. A frequency distribution, or ```FreqDist``` in NLTK, is basically an
enhanced Python dictionary where the keys are what's being counted, and the values are
the counts.

