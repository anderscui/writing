# Part-of-speech Tagging

**Part-of-speech** tagging is the process of converting a sentence, in the form of a list of words, into a list of tuples, where each tuple is of the form **(word, tag)**.

POS tagging is a necessary step before chunking. We can also use POS tags for grammar analysis and word sense disambiguation.

## Default tagging

Default tagging provides a baseline for POS tagging. It simply assigns the same POS tag to every token. We do this using the ```DefaultTagger``` class. This tagger is useful as a last-resort tagger, and provides a baseline to measure accuracy improvements.

```DefaultTagger``` is a subclass of ```SequentialBackoffTagger```. Every subclass of ```SequentialBackoffTagger``` must implement the ```choose_tag()``` method, which takes 3 arguments:

* The list of tokens
* The index of the current token
* The history, which is a list of the previous tags

```python
from nltk.tag import DefaultTagger
from nltk.corpus import treebank

tagger = DefaultTagger('NN')
print(tagger.tag(['Hello', 'World']))

# thought it's too simple, we can try to evaluate it
test_sents = treebank.tagged_sents()[3000:]
print(tagger.evaluate(test_sents))

# for sentences
print(tagger.tag_sents([['Hello', 'World', '.'], ['How', 'are', 'you', '?']]))

# untagging
from nltk.tag import untag
print(untag([('Hello', 'NN'), ('World', 'NN')]))
```

## Training a unigram POS tagger

A **unigram** generally refers to a single token. Therefore, a unigram tagger only uses a single word as its "context" for determining the POS tag.

```UnigramTagger``` inherits from ```NgramTagger```, which is a subclass of ```ContextTagger```, which inherits from ```SequentialBackoffTagger```.

```python
from nltk.tag import UnigramTagger
from nltk.corpus import treebank

# train
train_sents = treebank.tagged_sents()[:3000]
tagger = UnigramTagger(train_sents)

print(treebank.sents()[0])
print(tagger.tag(treebank.sents()[0]))

# test
test_sents = treebank.tagged_sents()[3000:]
print(tagger.evaluate(test_sents))
# 0.858881933952
```

It has almost 86 % accuracy for a tagger that only uses single word lookup to determine the part-of-speech tag. **All accuracy gains from here on will be much smaller**.

## Combining taggers with backoff tagging

**Backoff tagging** is one of the core features of ```SequentialBackoffTagger```. It allows you
to chain taggers together so that if one tagger doesn't know how to tag a word, it can pass
the word on to the next backoff tagger. If that one can't do it, it can pass the word on to the
next backoff tagger, and so on until there are no backoff taggers left to check.

```python
from nltk.tag import UnigramTagger, DefaultTagger
from nltk.corpus import treebank

# train
default_tagger = DefaultTagger('NN')
train_sents = treebank.tagged_sents()[:3000]
tagger = UnigramTagger(train_sents, backoff=default_tagger)

# test
test_sents = treebank.tagged_sents()[3000:]
print(tagger.evaluate(test_sents))
# 0.875847183251
```

## Training and combining ngram taggers

By themselves, ```BigramTagger``` and ```TrigramTagger``` perform quite poorly. This is
partly because they cannot learn context from the fist word(s) in a sentence. Since
a UnigramTagger class doesn't care about the previous context, it is able to have
higher baseline accuracy by simply guessing the most common tag for each word.

```python
from nltk.tag import DefaultTagger, UnigramTagger, BigramTagger, TrigramTagger
from nltk.corpus import treebank

train_sents = treebank.tagged_sents()[:3000]
test_sents = treebank.tagged_sents()[3000:]

bitagger = BigramTagger(train_sents)
print(bitagger.evaluate(test_sents))
# 0.11310166199

tritagger = TrigramTagger(train_sents)
print(tritagger.evaluate(test_sents))
# 0.0688107058062
```

Where ```BigramTagger``` and ```TrigramTagger``` can make a contribution is when we combine
them with backoff tagging. This time, instead of creating each tagger individually, we'll create
a function that will take train_sents, a list of SequentialBackoffTagger classes, and
an optional fial backoff tagger, then train each tagger with the previous tagger as a backoff.

```python
def backoff_tagger(train_sents, tagger_classes, backoff=None):
    combined = backoff
    for cls in tagger_classes:
        combined = cls(train_sents, backoff=combined)
    return combined

default_tagger = DefaultTagger('NN')
combined_tagger = backoff_tagger(train_sents, [UnigramTagger, BigramTagger, TrigramTagger], backoff=default_tagger)
print(combined_tagger.evaluate(test_sents))
# 0.880682063458
```

## Creating a model of likely word tags

```python
from nltk.probability import FreqDist, ConditionalFreqDist

def word_tag_model(words, tagged_words, limit=200):
    fd = FreqDist(words)
    cfd = ConditionalFreqDist(tagged_words)
    most_freq = (word for word, count in fd.most_common(limit))
    return dict((word, cfd[word].max()) for word in most_freq)
```

## Tagging with regular expressions

For instance, we can match numbers with \d+ to assign the tag **CD**(cardinal number).

```python
patterns = [
    (r'^\d+$', 'CD'),
    (r'.*ing$', 'VBG'),  # gerunds
    (r'.*ment$', 'NN'),  # movement
    (r'.*ful$', 'JJ'),  # wonderful
]

tagger = RegexpTagger(patterns)
print(tagger.evaluate(test_sents))
```

## Affix tagging

The ```AffixTagger``` class is another ```ContextTagger``` subclass, but this time the context is either the prefix or the stuff of a word.

## Training the Brill tagger

The ```BrillTagger``` class is a transformation-based tagger. It's not a subclass of ```SequentialBackoffTagger```. Instead, the ```BrillTagger``` class uses a series of rules to correct the results of an initial tagger. **These rules are scored based on how many errors they correct minus the number of new errors they produce**.

See more [Brill Tagger](https://en.wikipedia.org/wiki/Brill_tagger).

## Training the TnT tagger

**TnT** stands for **Trigrams'n'Tags**. It is a statistical tagger based on second order Markov models. More details [here](http://www.coli.uni-saarland.de/~thorsten/tnt/).

```python
from nltk.tag import tnt
from tag_util import train_sents, test_sents

tnt_tagger = tnt.TnT()
tnt_tagger.train(train_sents)
print(tnt_tagger.evaluate(test_sents))
# 0.875631340384

# deal with unknown tokens
default_tagger = DefaultTagger('NN')
unk_tagger = RegexpTagger(patterns, backoff=default_tagger)

tnt_tagger2 = tnt.TnT(unk=unk_tagger, Trained=True)
tnt_tagger2.train(train_sents)
print(tnt_tagger2.evaluate(test_sents))
# 0.896956615584
```

## Using WordNet for tagging

WordNet Synsets specify a POS tag to each word, but it's very restricted set of possible tags.

## Tagging proper names

Use ```names``` corpus.

## Classifier-based tagging

The ```ClassifierBasedPOSTagger``` class uses classifiation to do POS tagging. Features are extracted from words, and then passed to an internal classifier. The classifier classifies the features and returns a label, in this case, a POS tag.

The ```ClassifierBasedTagger``` class is often the most accurate tagger, but it's also one of the slowest taggers. If speed is an issue, we should stick with a BrillTagger class based on a backoff chain of NgramTagger subclasses and other simple taggers.

## Training a tagger with NLTK-trainer

As you can tell from all the taggers above, there are many different ways to train taggers, and it's impossible to know which methods and parameters will work best without doing training experiments. But training experiments can be tedious, since they often involve many small code changes (and lots of cut and paste) before you converge on an optimal tagger.

Try ```NLTK-Trainer```.

**NLTK-Trainer** is a collection of scripts that give you the ability to run training experiments without writing a single line of code. The project is available on GitHub at https://github.com/japerk/nltk-trainer and has documentation at http://nltk-trainer.readthedocs.org/.

