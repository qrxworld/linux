" Custom checkbox syntax highlighting
syn match todoCheckbox '\v^\s*\[\s\]'hs=e-2 contains=@NoSpell
syn match todoCheckboxDone '\v^\s*\[x\]'hs=e-2 contains=@NoSpell
syn match todoCheckboxPending '\v^\s*\[-\]'hs=e-2 contains=@NoSpell
syn match todoCheckboxCurrent '\v^\s*\[c\].*$' contains=@NoSpell
syn match fourDigitLineStart '\v^[0-9]{4}\s' contains=@NoSpell
syn match markdownHorizontalRule '\v^(\=\=\=+|-{3,}|\*{3,}|_{3,})$' contains=@NoSpell
syn match MarkdownNoteLine '\>>.*$' contains=@NoSpell

" Link to highlight groups
hi def link todoCheckbox Todo
hi def link todoCheckboxDone StatusLineTerm 
hi def link todoCheckboxPending MarkdownError 
hi def link todoCheckboxCurrent MarkdownError
hi def link fourDigitLineStart Number
hi def link markdownHorizontalRule MarkdownError
hi def link MarkdownNoteLine Todo 

syn region MarkdownNoteLine start=/^>>/ end=/$/ oneline contains=@NoSpell
hi def link MarkdownNoteLine MarkdownNoteHighlight

" Merge conflict marker syntax highlighting for Markdown
syn match markdownConflictMarkerBegin '^<<<<<<< .*$' contains=@NoSpell
syn match markdownConflictMarkerSeparator '^=======$' contains=@NoSpell
syn match markdownConflictMarkerEnd '^>>>>>>> .*$' contains=@NoSpell
" Link to highlight groups
hi def link markdownConflictMarkerBegin Error
hi def link markdownConflictMarkerSeparator WarningMsg
hi def link markdownConflictMarkerEnd Error

" Git repository reference syntax highlighting
syn match gitRepoReference '\v\<[^>]+\.git\>' contains=@NoSpell
hi def link gitRepoReference DiffAdd 

" @mention syntax highlighting (matches @word patterns)
syn match atMention '\v\@[a-zA-Z0-9_]+' contains=@NoSpell
hi def link atMention Character 

" Special words
syn case match
syn keyword allCapsWord TODO FIXME SPRINT FOCUS TODAY TODAYS SLEEP WEIGHT DREAMS
hi def link allCapsWord Constant
syn case ignore

" Email addresses
syn match emailAddress '\v[a-zA-Z0-9._%+-]+\@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' contains=@NoSpell
hi def link emailAddress Underlined

" HTTP/HTTPS URLs - escaped special characters
syn match httpUrl '\v(https?:\/\/)[a-zA-Z0-9._~:\/?#\[\]\@!$&''()=;,-]+' contains=@NoSpell
hi def link httpUrl Underlined

" Numbers in brackets [1], [123], etc.
syn match numbersInBrackets '\[[0-9]\+\]' contains=@NoSpell
hi def link numbersInBrackets Number
