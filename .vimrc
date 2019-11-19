" .vimrc
" By Yongheng Lin (yongheng.lin@gmail.com)

" Main References:
" https://github.com/amix/vimrc

" =====================================
" Detect OS

let osname = substitute(system('uname'), '\n', '', '')[0:5]
if osname == 'Linux'
    let os = 'linux'
elseif osname == 'Darwin'
    let os = 'osx'
elseif osname == 'CYGWIN'
    let os = 'cygwin'
else
    let os = 'unknown'
endif

" =====================================
" General

" eliminate vi-compatibility
set nocompatible

" set the number of lines that are remembered
set history=500

" turn off backup
set nobackup
set nowritebackup
set noswapfile

" reload file changed outside
set autoread

" set encoding
set encoding=utf-8

" disable error bells
set noerrorbells
set novisualbell
set t_vb=

" set timeout length
set timeoutlen=500

" remap <leader>
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","

" toggle paste mode
map <leader>pp :setlocal paste!<CR>

" =====================================
" Display

" theme
colorscheme desert
set background=dark

" enable syntax highlighting
syntax enable

" display line number
set number

" toggle line number
map <leader>nn :set number!<CR>

" display 80th column
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
highlight ColorColumn ctermbg=4

" set number of screen lines to use for the command-line
set cmdheight=2

" show status line
set laststatus=2

" =====================================
" File

" enable filetype plugins
filetype plugin on
filetype indent on

" set EOL format
set fileformats=unix,dos,mac

" prevent from expanding tab
autocmd FileType make setlocal noexpandtab

" treat .md file as .markdown file
au BufRead,BufNewFile *.md set filetype=markdown

" convert markdown to HTML
" nmap <leader>md :%!markdown % <CR>

" remove trailing whitespace on save
" function! RemoveTrailingWhitespace()
"     exe 'normal mz'
"     %s/\s\+$//ge
"     exe 'normal `z'
" endfunction
" autocmd BufWritePre * :call RemoveTrailingWhitespace()

" save
nmap <leader>w :w!<CR>

" exit
nmap <leader>q :q<CR>

" save and exit
nmap <leader>wq :wq<CR>

" return to last edit position when opening file
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif

" remember info about open buffers on close
set viminfo^=%

" ======================================
" Navigation

" treat long lines as break lines
map j gj
map k gk

" keep cursor away from top and bottom
set scrolloff=5

" keep cursor centered after movement
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" move between buffers
map <leader>h :bprevious<CR>
map <leader>l :bnext<CR>

" close buffer
map <leader>d :bdelete<CR>

" hide abandoned buffers
set hidden

" switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>

" buffer switching behavior
try
    set switchbuf=useopen,usetab,newtab
    set showtabline=2
catch
endtry

" manage tabs
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove

" opens a new tab with the current buffer's path
map <leader>te :tabedit <C-R>=expand('%:p:h')<CR>/

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" move cursors faster
nnoremap <C-j> 10j
nnoremap <C-k> 10k
nnoremap <C-h> b
nnoremap <C-l> w

" move lines
" nnoremap <C-d>      :m .+1<CR>==
" nnoremap <C-u>      :m .-2<CR>==
" inoremap <C-d> <Esc>:m .+1<CR>==gi
" inoremap <C-u> <Esc>:m .-2<CR>==gi
" vnoremap <C-d>      :m '>+1<CR>gv=gv
" vnoremap <C-u>      :m '<-2<CR>gv=gv

" =====================================
" Search

" search behavior
set hlsearch
set incsearch
set ignorecase
set smartcase

" search visually selected text
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
    \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \ gvy/<C-R><C-R>=substitute(
    \     escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \ gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \ gvy?<C-R><C-R>=substitute(
    \     escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \ gV:call setreg('"', old_reg, old_regtype)<CR>

" search and replace visually selected text
" http://stackoverflow.com/a/676619
vnoremap <leader>r0 "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <leader>r  "hy:.,$s/<C-r>h//gc<left><left><left>

" remove highlighting
map <silent> <leader><CR> :noh<CR>

" set alias for '/' and '?'
map <Space> /
map <C-Space> ?

" =====================================
" Editing

" tab
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" space
set autoindent
set cindent
set wrap

" turn on the wild menu
set wildmenu
set wildignore=*.o,*~,*.pyc

" don't redraw while executing macros
set lazyredraw

" turn on magic for regular expression
set magic

" show matching bracket
set showmatch
set mat=2

" set line breaking behavior
set wrap
set linebreak
set nolist

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" create new line above/below
nmap gO O<ESC>j
nmap go o<ESC>k

" pair and ready for input
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i

" yank and replace word
nmap <leader>yw yiw
nmap <leader>rw ciw<C-R>0<ESC>

" spell checking
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" ======================================
" Vundle

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugins
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
Plugin 'epeli/slimux'

call vundle#end()

" ======================================
" Plugins

" NERDTree
autocmd bufenter *
    \ if (winnr('$') == 1 && exists('b:NERDTreeType') &&
        \ b:NERDTreeType == 'primary') | q |
    \ endif
map <C-n> :NERDTreeToggle<CR>
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1

" NERDCommenter
let g:NERDDefaultAlign = 'left'

" vim-airline
if os == 'linux'
    let g:airline_powerline_fonts = 0
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
else
    let g:airline_powerline_fonts = 1
endif
" let g:airline_detect_whitespace = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" ctrlp.vim
let g:ctrlp_show_hidden = 1

" vim-markdown
" let g:vim_markdown_folding_disabled = 1

" Tabular
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:<CR>
vmap <leader>a: :Tabularize /:<CR>
nmap <leader>as :Tabularize / \+/l0<CR>
vmap <leader>as :Tabularize / \+/l0<CR>
nmap <leader>ao :Tabularize /<<<CR>
vmap <leader>ao :Tabularize /<<<CR>

" Slimux
map <leader>s :SlimuxREPLSendLine<CR>
vmap <leader>s :SlimuxREPLSendSelection<CR>
map <leader>a :SlimuxShellLast<CR>
map <leader>k :SlimuxSendKeysLast<CR>

" ======================================
" GUI

" set extra options when running in GUI mode
if has('gui_running')
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    if has('gui_gtk2')
        set guifont=Inconsolata\ 12
    elseif has('gui_win32')
        set guifont=Consolas:h11:cANSI
    endif
endif
