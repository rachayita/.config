	"enter the current millenia
	set nocompatible
set tabstop=1
set number relativenumber
set autoindent
set smartindent
set showmatch
"set hlsearch
set nobackup
set noswapfile
set splitbelow splitright
 
set ignorecase
set smartcase

" Use increment searching (search while typing)
set incsearch

"

	"enable syntax and plugins (for netrw)
	syntax enable
	filetype plugin on

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

" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix

" Configure the `make` command to run RSpec
"set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter
set makeprg=cargo\ build

" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back



"                          THANK YOU!

"                    Download this file at:
"                github.com/mcantor/no_plugins

" my leader
let mapleader = "\<Space>"

"copy paste in clipboard
vnoremap <Leader>y "+y
map <Leader>p "+p

" <leader><leader> toggles between buffers
nnoremap <leader>a <c-^>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>s :wq<CR>
map <Leader>f <C-f>
map <Leader>b <C-b>
map <Leader>e <C-w>w

"autocmd vimenter * NERDTree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>z :FZF<CR>
map <Leader>x :SK<CR>
map <Leader>t :terminal<CR>

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

" Type 12<Enter> to go to line 12 (12G breaks my wrist)
" Hit Enter to go to end of file.
" Hit Backspace to go to beginning of file.
nnoremap <CR> G
nnoremap <BS> gg

" Quickly select text you just pasted:
noremap gV `[v`]

" Stop that stupid window from popping up:
map q: :q

nnoremap ; :

call plug#begin()
Plug 'vim-airline/vim-airline'
" Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/dense-analysis/ale.git'
Plug 'https://github.com/rust-lang/rust.vim.git'
Plug 'https://github.com/terryma/vim-expand-region.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/airblade/vim-rooter.git'
Plug 'https://github.com/racer-rust/vim-racer.git'
Plug 'autozimu/LanguageClient-neovim', {
     \ 'branch': 'next',
     \ 'do': 'bash install.sh',
     \ }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'https://github.com/vim-syntastic/syntastic.git'
call plug#end()

" Plug 'https://github.com/racer-rust/vim-racer.git'
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap gt <Plug>(rust-def-tab)
au FileType rust nmap <leader>d <Plug>(rust-doc)
 
" Plug 'autozimu/LanguageClient-neovim'
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <leader>k :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Plugin 'https://github.com/rust-lang/rust.vim.git'
let g:rustfmt_autosave = 1

" Plugin 'https://github.com/terryma/vim-expand-region.git'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"https://github.com/vim-syntastic/syntastic.git
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

"fzf
set rtp+=~/.bin/fzf

"sk
set rtp+=~/.bin/skim

" Prevent replacing paste buffer on paste:
" I can select some text and paste over it without worrying 
" if my paste buffer was replaced by the just removed text .
" vp doesn't replace paste buffer
"(place it close to end of ~/vimrc) *****
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
"************************************************
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"************************************************
