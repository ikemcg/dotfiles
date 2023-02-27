set nocompatible        " use vim rather than vi settings, must be first line
filetype off            " required

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'   " Soraized theme
Plug 'tpope/vim-surround'                 " Mappings for editing surroundings
Plug 'tpope/vim-repeat'                   " Extend . command support for vim-surroung
Plug 'dense-analysis/ale'                 " Asynchronous Lint Engine
Plug 'scrooloose/nerdtree'                " Filesystem tree explorer
Plug 'scrooloose/nerdcommenter'           " Commenting powers
Plug 'majutsushi/tagbar'                  " Class outline viewer based on ctags
Plug 'godlygeek/tabular'                  " Text alignment
Plug 'mattn/emmet-vim'                    " Expands abbreviations
Plug 'maksimr/vim-jsbeautify'             " Beautify JS and CSS
"Plug 'SirVer/ultisnips'                   " Snippets!
Plug 'honza/vim-snippets'                 " Snippet repository for UltiSnips
Plug 'editorconfig/editorconfig-vim'      " Set editing prefs based on .editorconfig file
"Plug 'othree/yajs.vim'                    " JavaScript Syntax file
Plug 'pangloss/vim-javascript'            " Improved Javascript indentation and syntax support
Plug 'heavenshell/vim-jsdoc'              " Generate JSDoc
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'                          " PHP Documentor
Plug 'groenewege/vim-less'                " Indentation and highlighing for LESS files
Plug 'tpope/vim-markdown'                 " Syntax for Markdown
Plug 'jwalton512/vim-blade'               " Syntax for Blade files
Plug 'posva/vim-vue'                      " Syntax for Vue.js components
Plug 'junegunn/fzf'                       " Fuzzy finder for vim
Plug 'junegunn/fzf.vim'                   " Fuzzy finder for vim
Plug 'vim-airline/vim-airline'            " Lean & mean status/tabline
Plug 'vim-airline/vim-airline-themes'     " Airline themes
Plug 'hashivim/vim-terraform'             " Indentation and highlighting for Terraform files

" Initialize plugin system
call plug#end()

" colors
syntax on
set termguicolors
set background=dark
colorscheme solarized

" temporary fix for python 3 warnings
if has('python3')
  silent! python3 1
endif

let g:gruvbox_contrast_dark = "hard"

" Turn on at 120 cols
highlight ColorColumn guibg=#002b36
let &colorcolumn=join(range(121,999),",")

filetype plugin indent on       " turn on filetype, filetype plugins, and filetype indent
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set hlsearch
set incsearch
set showmode        " always show what mode we're in
set nobackup		" do not keep a backup file, use versions instead
set history=1000    " a more reasonable history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set nofoldenable    " disable folding
set laststatus=2    " airline plugin requires that we always show the status line, hidden except for splits othewise
set wildmenu        " tab completion for opening files
set autowrite       " save on buffer switch
set clipboard=unnamed " enables clipboard sharing in osx

setlocal cm=blowfish2

set tabstop=2       " a tab is four spaces
set shiftwidth=2    " spaces to use for autoindenting
set softtabstop=2   " when hitting <BS>, pretend like a tab is removed event if spaces
set expandtab       " expands tabs into spaces, no tab chars
set wrapscan
set autoindent		" always set autoindenting on
set smartindent     " syntax adaptive autoindenting, does not obviate the need for autoindent
"set number          " always show line numbers
set ignorecase      " ignore case when searching
set smartcase       " turns off ignore case when pattern contains uppercase letter
set visualbell      " don't beep
set noerrorbells    " don't beep

set cm=blowfish     " default encryption

set title           " display file name in osx terminal's top window bar
set hidden          " allows files in buffers to remain open
set scrolloff=3     " maintains 3 lines below cursor as cursor moved outside viewport

"highlight clear SignColumn
highlight SignColumn ctermbg=black

" `a returns to line and column marked by ma, and so is more usefull.  make it
" easier to use, by swapping with '
nnoremap ' `
nnoremap ` '

" toggle spelling with F5
"imap <F5> <C-o>:setlocal spell! spelllang=en_us<CR>
"inoremap <F5> <C-\><C-O>:setlocal spelllang=en_us spell! spell?<CR>
imap <Leader>s <C-o>:setlocal spell! spelllang=en_us<CR>
nmap <Leader>s :setlocal spell! spelllang=en_us<CR>

" set leader to comma
let mapleader = ","
let g:mapleader = ","

" keep comma as repeat find character reverse
noremap \ ,

" fast saves
nmap <leader>w :w!<cr>

"Auto change directory to match current file ,cd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

set pastetoggle=<leader>p

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal g'\"" | endif
endif

" Abbreviations
abbrev pft PHPUnit_Framework_TestCase
abbrev gm !php artisan generate:model
abbrev gc !php artisan generate:controller
abbrev gmig !php artisan generate:migration

" Auto-remove trailing spaces
"autocmd BufWritePre *.php :%s/\s\+$//e

" Laravel framework commons
nmap <leader>lr :e app/routes.php<cr>
nmap <leader>lca :e app/config/app.php<cr>81Gf(%O
nmap <leader>lcd :e app/config/database.php<cr>
nmap <leader>lc :e composer.json<cr>

" open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" use custom snippets, ignore defaults
"let g:snippets_dir = "~/.vim/snippets"

au BufRead,BufNewFile *.es6 set filetype=javascript
au BufRead,BufNewFile *.phtml set filetype=php

" simplify moving between windows
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
noremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" source .vimrc
:nnoremap <Leader>sv :so $MYVIMRC<CR>
:nnoremap <leader>ev :e $MYVIMRC<CR>

" source worklog
:nnoremap <Leader>wl :e ~/projects/worklog<cr>

" delete buffer without removing split
nmap <silent> <leader>d :bp\|bd #<CR>

"---------------------------- plugins ----------------------------"

let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" ALE - Asynchronous Linting Engine
"let g:ale_disable_lsp = 1  " Leave lsp to coc.nvim
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

:nnoremap <Leader>af :ALEFix<CR>
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

let g:ale_linter_aliases = {
\   'vue': ['vue', 'javascript']
\}
let g:ale_linters = {
\   'php': ['phpcs'],
\   'javascript': ['eslint'],
\   'vue': ['eslint', 'vls']
\}
let g:ale_php_phpcs_standard='PSR2'
let g:ale_fixers = {
\   'php': ['php_cs_fixer'],
\   'javascript': ['eslint'],
\}

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"let g:SuperTabDefaultCompletionType = '<c-i>'

" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsListSnippets = "<c-l>"

nnoremap <c-l> :bnext<CR>
nnoremap <c-h> :bprevious<CR>

" pluggin mappings
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>t :TagbarToggle<CR>

" mappings for tabularize
nmap <Leader>tb= :Tabularize /=<CR>
vmap <Leader>tb= :Tabularize /=<CR>
nmap <Leader>tb> :Tabularize /=><CR>
vmap <Leader>tb> :Tabularize /=><CR>
nmap <Leader>tb: :Tabularize /:\zs<CR>
vmap <Leader>tb: :Tabularize /:\zs<CR>

nmap <leader>sf <Plug>SQLU_Formatter<CR>
vmap <leader>sf <Plug>SQLU_Formatter<CR>

" JS Beautify
map <Leader>b :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <leader>b :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>b :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <leader>b :call CSSBeautify()<cr>
autocmd FileType less noremap <buffer> <leader>b :call CSSBeautify()<cr>

" JsDoc
map <Leader>jd :JsDoc<cr>

" Fzf
noremap <silent> <c-p> :Files<CR>

" Add phpDocumentor comment just above code block
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <leader>pd :call pdv#DocumentWithSnip()<CR>

" search recusively upwards for tags file
set tags=tags;/

" show quickfix window when there's an error
autocmd QuickFixCmdPost * nested cwindow | redraw!

"autocmd Filetype php setlocal ts=4 sts=4 sw=4 expandtab
"autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
