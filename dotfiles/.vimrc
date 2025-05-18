"source ~/.vim/defaults.vim  " Load Vim's default settings (includes syntax highlighting
filetype plugin indent on  " Enable filetype detection and plugin/indent info
syntax on
set termguicolors
autocmd BufRead,BufNewFile *.md setfiletype markdown
set t_Co=256
set termguicolors

" Autoupdates
set autoread                                " Automatically reload files changed externally
set updatetime=1000                         " Set idle time to 1 second
autocmd FocusGained,BufEnter * checktime    " Check for external changes when gaining focus or entering a buffer
autocmd CursorHold * checktime              " Check for external changes when the cursor is idle

" Wrapping
set wrap        " Enable line wrapping
set linebreak   " Break lines at word boundaries
set nolist      " Turn off 'list' mode as it conflicts with linebreak

" Formatting
set relativenumber 

" Tabs
autocmd FileType * setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

"""""""""""
" Keyboard shortcuts
"""""""""""
let mapleader = ","
inoremap jj <Esc>

" Insert current time in HHMM format in normal mode
nnoremap <leader>t "=strftime("%H%M")<CR>P  
" Insert current time in HHMM format in insert mode
inoremap <leader>t <C-R>=strftime("%H%M")<CR> 
" Insert horizontal rule with leader+hr
nnoremap <leader>hr o<CR><CR><CR><Esc>40i=<Esc>o<CR><CR><CR><Esc>

" MARKDOWN
imap ,[ [ ] 

" LLMs
nnoremap ,sum :%w !hey 'summarize the current buffer' --more<CR>
nnoremap ,next :%w !hey 'what should i work on next?' --more<CR>
nnoremap ,save :!cd ~/oz/;clear;save<CR>
nnoremap ,hey :%w !hey --more --prompt '

" Yank into system clipboard in visual mode
vnoremap y y:call system('xsel -ib', @0)<CR>:redraw!<CR>
vnoremap d d:call system('xsel -ib', @0)<CR>:redraw!<CR>
" Yank current line
nnoremap yy :call system('xsel -ib', getline('.'))<CR>:redraw!<CR>
nnoremap dd :call system('xsel -ib', getline('.'))<CR>dd:redraw!<CR>
