" Custom checkbox syntax highlighting
syn match todoCheckbox '\v^\s*\[\s\]'hs=e-2 contains=@NoSpell
syn match todoCheckboxDone '\v^\s*\[x\]'hs=e-2 contains=@NoSpell
syn match todoCheckboxPending '\v^\s*\[-\]'hs=e-2 contains=@NoSpell
syn match todoCheckboxCurrent '\v^\s*\[c\].*$' contains=@NoSpell
syn match fourDigitLineStart '\v^[0-9]{4}\s' contains=@NoSpell
syn match markdownHorizontalRule '\v^(\=\=\=+|-{3,}|\*{3,}|_{3,})$' contains=@NoSpell
" Link to highlight groups
hi def link todoCheckbox Todo
hi def link todoCheckboxDone StatusLineTerm 
hi def link todoCheckboxPending MarkdownError 
hi def link todoCheckboxCurrent MarkdownError
hi def link fourDigitLineStart Number
hi def link markdownHorizontalRule MarkdownError

" Merge conflict marker syntax highlighting for Markdown
syn match markdownConflictMarkerBegin '^<<<<<<< .*$' contains=@NoSpell
syn match markdownConflictMarkerSeparator '^=======$' contains=@NoSpell
syn match markdownConflictMarkerEnd '^>>>>>>> .*$' contains=@NoSpell
" Link to highlight groups
hi def link markdownConflictMarkerBegin Error
hi def link markdownConflictMarkerSeparator WarningMsg
hi def link markdownConflictMarkerEnd Error
