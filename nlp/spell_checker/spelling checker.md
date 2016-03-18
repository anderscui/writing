# Spelling Correction

## Applications

* Word Processor (Word, Outlook, Evernote)
* Search Engine (Google)
* Phones

## Spelling Tasks

* Spelling Error Detection
* Spelling Error Correction

Ways to correct:
* Autocorrect: hte -> the
* Suggest one
* Suggest list

## Types of Spelling Errors

* Non-word Errors: graffe (giraffe)
* Read-word Errors (harder to detect, why?)
	- Typographical Errors (排印错误)
	- Cognitive Errors (homophones): piece -> peace


## Rates of Spelling Errors

* Web Queries: 26%
* Retyping, nobackspace: 13%
* Retyping: 1-2%


TODO: Steps to put the elephant into the box;;;

## Non-word Spelling Errors

### Detect

* any word not in a dict
* the larger the dict the better

### Correct

* generate **candicates** (real words that are similar to error)
* choose the best one
	- Shortest weighted edit distance
	- Highest noisy channel prob


## Real Word Spelling Errors

* For each word *w*, generate candicate set:
	- with similar pronunciations
	- with similar spelling
	- include *w*
* Choose best candidate
	- Noisy Channel
	- Classifier


		
	




