# Why Vim?

"There is no great writing, only great rewriting".

	-- Louis Brandeis

**"Minimal effort. Maximal effect."**

# Modes

* Normal: run commands, default mode
* Insert: write the text
* Visual: visually select a bunch of text

# First Steps

* edit/e: editing a file
* write/w: write the text from buffer (memory) to the disk
* quit/q: quit
* q!: quit without saving

# Write the Text

* i: [i]nsert text just *before* the cursor
* I: [I]nsert text at the start of the line
* a: [a]ppend text just *after* the cursor
* A: [A]ppend text at the end of the line
* o: [o]pen a new line below
* O: [O]pen a new line above (press shift -> above:))
* s: [s]ubstitute a char
* S: [S]ubstitute a line
* r: [r]eplace a char
* R: [R]eplace continuous chars

# Moving Around

* hjkl
* 3j -> repeat j 3 times
* ^
* $ (think about regex)
* ctrl-b(f): pageup/down

* 3G: go to the third line
* 1G: the first line
* G: the last line
* HML: high, middle, low pos in the current window

* w: next [w]ord
* b: one word [b]ackward 
* 2w/2b
* e: [e]nd of the next word
* ): the next sentence
* }: the next paragraph
* ( or {
* 

`:help work-motions`, `:help cursor-motions`

## Bookmarks

* ma: create a mark named 'a'
* 'a: go to the line
* `a: go to the exact pos

## Jump

* ctrl-o
* ctrl-i

## Parts of the text

~: flip case
vap, ~: visually select a paragraph, flip its case
vaw: a word
va": a quoted thing
vab: a block within a pair of parentheses

`:help object-motions`, `:help text-motions`

# Help

TODO

# Editing

* d: delete(cut)
* y: yank(copy)
* p: paste

Then combine the operation notation and the text object notation.

* dl: delete a [l]etter
* dw: a word
* dd: a line
* yy: yank a line
* yap: yank a paragraph
* p: paste after current cursor
* P: before cur cursor

* xp: swap two chars, delete then paste after
* dwwP: swap two words

* u: undo
* earlier 3m: 3 minutes ago
* later 45s
* undo 5
* undolist

`:help undo-redo`, `:help :undolist`

# Search

* /keyword<cr>
* /\<keyword\>: exact search
* /\d\+: digits
* n:
* b:

`:help pattern`

# Multiplicity

TODO

# More

* %: bounce between matched brackets.
* !: run a shell command (like ipython)

