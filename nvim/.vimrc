"enter the current millenia
set nocompatible
set tabstop=2
set shiftwidth=2
set expandtab
set number relativenumber
set autoindent
set smartindent
set showmatch
"set hlsearch
set nobackup
set noswapfile
set splitbelow splitright
set encoding=utf-8
set ignorecase
set smartcase
set colorcolumn=90 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set autoread
set bs=2 " backspace

" list listchars 
set list 
set lcs=tab:»· 
set lcs+=trail:· 

" Show those damn hidden characters
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

" Use increment searching (search while typing)
set incsearch

"search down into subfolders
"provides tab-completion for all file related task
set path+=**

"Display all matching files when we tab complete
set wildmenu


" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer


" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" SNIPPETS:

" Read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)

" BUILD INTEGRATION:
" http://philipbradley.net/rspec-into-vim-with-quickfix
" Configure the `make` command to run RSpec
" set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter
set makeprg=cargo\ build

" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back

" github.com/mcantor/no_plugins
" ----

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help filetype detection
autocmd BufRead *.md set filetype=markdown

"
inoremap <buffer> { {}<ESC>i
inoremap <buffer> [ []<ESC>i
inoremap <buffer> ( ()<ESC>i
inoremap <buffer> " ""<ESC>i
inoremap <buffer> ' ''<ESC>i
inoremap <buffer> ` ``<ESC>i


" my leader
let mapleader = "\<Space>"

noremap <leader>s :source $XDG_CONFIG_HOME/nvim/.vimrc<cr>
"copy paste in clipboard
vnoremap <Leader>y "+y
map <Leader>p "+p

" <leader><leader> toggles between buffers
nnoremap <leader>a <c-^>
nnoremap <leader>A :bn<CR>
nnoremap <leader>r :bwipeout<CR>

nnoremap <Leader>w :wq<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader><CR> :w<CR>
map f <C-d>
map F <C-u>
map <Leader>e <C-w>w
map <Leader>d daw
map <Leader>D dawi
" map <Leader>c gcc

"autocmd vimenter * NERDTree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>z :FZF<CR>
map <Leader>x :SK<CR>
map <Leader>l :terminal<CR>

" search and replace
" search things usual way using /something
" hit cs, replace first match, and hit <Esc>
" hit n.n.n.n.n. reviewing and replacing all matches
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Automatically jump to end of text you pasted:
" paste multiple lines multiple times with simple ppppp.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Quickly select text you just pasted:
noremap gV `[v`]

" Stop that stupid window from popping up:
map q: :q

let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2'

"fzf
set rtp+=/usr/bin/fzf

"sk
set rtp+=/usr/bin/sk

" Jump to start and end of line using the home row keys
map H ^
map L $

" on selection in visual mode
highlight   Visual      cterm=reverse        ctermbg=black   gui=reverse
highlight   IncSearch   cterm=reverse,bold   ctermbg=black   gui=reverse

call plug#begin()
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/rust-lang/rust.vim.git'
Plug 'https://github.com/terryma/vim-expand-region.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/airblade/vim-rooter.git'
Plug 'https://github.com/lifepillar/vim-mucomplete.git'
Plug 'https://github.com/mattn/webapi-vim.git' "an interface to web apis
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'autozimu/LanguageClient-neovim', {
     \ 'branch': 'next',
     \ 'do': 'bash install.sh',
     \ }
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'vifm/vifm.vim'
Plug 'ap/vim-css-color'

" both are related in order
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/preservim/vim-markdown.git'

" paren edting
Plug 'https://github.com/tpope/vim-surround.git'

call plug#end()

"https://github.com/vim-airline/vim-airline.git
let g:airline_powerline_fonts = 1

"Plug 'https://github.com/lifepillar/vim-mucomplete.git'
set completeopt=menuone,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " Add only if Vim beeps during completion
let g:mucomplete#enable_auto_at_startup = 1

" Plug 'autozimu/LanguageClient-neovim'
" Note: download rust-analyzer in ~/.local/bin
set hidden
let g:LanguageClient_serverCommands = { 'rust': ['rust-analyzer'], }
let g:LanguageClient_preferredMarkupKind = ['plaintext', 'markdown']
let g:LanguageClient_floatingHoverHighlight = 'Normal:tooltip'
highlight tooltip  ctermfg=85 ctermbg=232 guifg=#9cffd3 guibg=#202020
" Note:  if you are using Plug mapping you should not use `noremap` mappings
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent> K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

" Plugin 'https://github.com/rust-lang/rust.vim.git'
let g:rustfmt_autosave = 1
" let g:rustfmt_emit_files = 1
" let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
"enable syntax and plugins (for "netrw") and rust.vim plugin
syntax enable
filetype plugin indent on

" Plugin 'https://github.com/terryma/vim-expand-region.git'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" format para to 80 char (selected or not)
nnoremap <Leader>g gqap
xnoremap <Leader>g gqa

" highlighting a selection on yank
 au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=2000}

" Plug 'vifm/vifm.vim'
map <Leader>v :Vifm<CR>

" rust debugger
" Note: gdb installation required
let g:termdebugger="rust-gdb"
let g:termdebug_wide=1
map <Leader>b :packadd termdebug<CR>

" Plug 'https://github.com/airblade/vim-gitgutter.git'
highlight clear SignColumn

"  Plug 'https://github.com/godlygeek/tabular.git'
map <Leader>t :Tabularize /

" nvimdiff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

map <Leader>m ]c "hunk downward
map <Leader>M [c "hunk upward
" completely fold all line above and below
map <Leader>O :set diffopt+=context:0<CR>

" Plug 'https://github.com/vimwiki/vimwiki.git'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" latex
setlocal iskeyword+=:,-
setlocal makeprg=pdflatex\ -file-line-error\ -interaction=nonstopmode\ %

iab <buffer> ,b \begin{
iab <buffer> ,e \end{

let g:tex_flavor = "latex"
set suffixes+=.log,.aux,.bbl,.blg,.idx,.ilg,.ind,.out,.pdf

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction

" Prevent replacing paste buffer on paste:
" Note: place it close to end of file
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
