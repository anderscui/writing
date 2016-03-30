# Extracting Chunks

**Chunk extraction**, or **partial parsing**, is the process of extracting short phrases from a POS tagger sentence. This is different from **full parsing** in that we're interested in standalone chunks, or phrases, instead of full [parse trees](https://en.wikipedia.org/wiki/Parse_tree).

The idea is that meaningful phrases can be extracted from a sentence by looking for **particular patterns of POS tags**.

## Chunking and chinking with regex

A ```ChunkRule``` class specifis what to include in a chunk, while a ```ChinkRule``` class specifies what to exclude from a chunk. In other words, chunking creates chunks, while chinking breaks up those chunks.

```python
chunker = RegexpParser(r'''
NP:
    {<DT><NN.*><.*>*<NN.*>}
    }<VB.*>{'''
)

print(chunker.parse([('the', 'DT'), ('book', 'NN'), ('has', 'VBZ'), ('many', 'JJ'), ('chapters', 'NNS')]))
```

The **ChunkRule** and **ChinkRule** classes are both subclasses of **RegexpChunkRule**, and require two arguments: the pattern and a description of the rule. **ChunkString** is an object that starts with a **flat tree**, which is then modified by each rule when it is passed into the rule's ```apply()``` method. A ChunkString is converted back to a Tree with the ```to_chunkstruct()``` method.

Below is the code to demenstrate the chunking process:

```python
t = Tree('S', [('the', 'DT'), ('book', 'NN'), ('has', 'VBZ'), ('many', 'JJ'), ('chapters', 'NNS')])
cs = ChunkString(t)
print(cs)
#  <DT>  <NN>  <VBZ>  <JJ>  <NNS> 

ur = ChunkRule('<DT><NN.*><.*>*<NN.*>', 'chunk determiners and nouns')
ur.apply(cs)
print(cs)
# {<DT>  <NN>  <VBZ>  <JJ>  <NNS>}

ir = ChinkRule('<VB.*>', 'chink verbs')
ir.apply(cs)
print(cs)
# {<DT>  <NN>} <VBZ> {<JJ>  <NNS>}

print(cs.to_chunkstruct())
# (S (CHUNK the/DT book/NN) has/VBZ (CHUNK many/JJ chapters/NNS))

# show tree diagram
cs.to_chunkstruct().draw()

chunker = RegexpChunkParser([ur, ir])
print(chunker.parse(t))
# (S (NP the/DT book/NN) has/VBZ (NP many/JJ chapters/NNS))

# alternative patterns
chunker1 = RegexpParser(r'''
NP:
    {<DT><NN.*>}
    {<JJ><NN.*>}'''
)
print(chunker1.parse(s))

chunker2 = RegexpParser(r'''
NP:
    {(<DT>|<JJ>)<NN.*>}'''
)
print(chunker2.parse(s))
``` 

## Merging and splitting chunks with regex

A ```MergeRule``` class can merge two chunks together based on the end of the first chunk and  the beginning of the second chunk. A ```SplitRule``` class will split a chunk into two chunks based on the specifid split pattern.

* SplitRule: ```<NN.*>}{<.*>```, split a chunk after a noun
* MergeRule: ```<NN.*>{}<NN.*>```



## Expanding and removing chunks with regex

## Partial parsing with regex

## Training a tagger-based chunker

## Classification-based chunking

## Extracting named entities

## Extracting proper noun chunks

## Extracting localtion chunks

## Training a named entity chunker

## Training a chunker with NLTK-Trainer

