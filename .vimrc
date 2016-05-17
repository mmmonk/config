" ~/.vimrc file
"
" ideas http://amix.dk/vim/vimrc.html
" vim --servername "$HOST-GVIM" --remote-tab-silent

filetype plugin indent on
set autoindent    " autoindent
set autoread      " automatically read a file when it was modified outside of Vim
set background=dark
set backspace=indent,eol,start " powerful backspaces
set tags=./tags,./.git/tags;
set completeopt=longest,menu,preview " completion options
set display=uhex  " include "uhex" to show unprintable characters as a hex number
"set enc=iso-8859-2
set enc=utf-8
set esckeys       " recognize keys that start with <Esc> in Insert mode
set expandtab     " spaces instead of tabs
set ff=unix       " force unix fileformat
set ffs=unix,dos,mac  " list of file formats to look for when editing a file
set hidden        " allows hidden buffers to stay unsaved
"set hls
set ignorecase    " ignore case when using a search pattern
set incsearch     " Incremental search.
set laststatus=2  " when to use a status line for the last window
set linebreak     " wrap long lines at a character in 'breakat'
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set modeline
set modelines=0
set mouse=a
set nobackup      " no backups
set nocompatible
set noerrorbells
set nosplitbelow
set noswapfile
set nowritebackup
"set paste
"set relativenumber
set ruler
set scs
set shiftwidth=2
set showcmd       " Show current vim command in status bar
set showmatch     " Show matching parentheses/brackets
set showmode      " Show current vim mode
set smartcase     " override 'ignorecase' when pattern has upper case characters
set tabstop=2
set textwidth=0   " don't wrap words
set title
set ttyfast       " better terminal
set ttymouse=xterm
set visualbell    " use a visual bell instead of beeping
set wildignore=*.swp,*.bak,*.pyc,*.class
set wrap          " Wrap too long lines
set t_Co=256
"set verbose=5
set colorcolumn=80

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='20,\"200,:50,%,n~/.viminfo
fixdel

" {{{ colors
colorscheme ron
hi clear

" tabs colors "{{{
hi TabLineFill ctermfg=blue ctermbg=blue
hi TabLine ctermfg=white ctermbg=blue
hi TabLineSel ctermfg=yellow ctermbg=darkblue
"}}}

" folds "{{{
hi FoldColumn ctermfg=green ctermbg=darkgrey
hi Folded ctermfg=cyan ctermbg=darkgrey
"}}}

" status highlights "{{{
hi User1 ctermbg=darkblue ctermfg=black cterm=bold
hi User2 ctermbg=darkblue ctermfg=cyan cterm=bold
hi User3 ctermbg=darkblue ctermfg=white cterm=bold
hi User4 ctermbg=darkblue ctermfg=green cterm=bold
hi User5 ctermbg=red ctermfg=darkblue cterm=bold
hi User6 ctermbg=darkblue ctermfg=magenta cterm=bold
"}}}

" splitbar
hi VertSplit ctermbg=darkblue ctermfg=green cterm=bold

" reverse colors for selection 
hi visual cterm=reverse

" default the statusline to green when entering Vim
hi StatusLine ctermbg=darkblue ctermfg=green cterm=bold
hi StatusLineNC ctermbg=darkblue ctermfg=blue cterm=bold

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi User4 ctermbg=red ctermfg=black cterm=bold
  au InsertLeave * hi User4 ctermbg=darkblue ctermfg=green cterm=bold
endif
" }}}

set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%1*
set statusline+=%n                      " buffer number
set statusline+=%0*
set statusline+=\ 
set statusline+=%4*
set statusline+=%F\                          " file name
set statusline+=%5*
set statusline+=%h%m%r%w                     " flags
set statusline+=%0*
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%6*
set statusline+=\ %{&paste?'paste':''}              " file format
set statusline+=%0*
set statusline+=%=                           " right align
set statusline+=%6*
set statusline+=%{getcwd()}\ 
set statusline+=%2*
set statusline+=[%b,0x%B]                 " current char
set statusline+=%3*
set statusline+=\ [%l,%c%V]\ %<%P\             " offset
set statusline+=%2*
set statusline+=%{'['.&spl.']'}
set statusline+=%0*

" save read-only file using sudo 
cmap w!! %!sudo tee > /dev/null %

filetype plugin indent on

if &term =~ "xterm" || &term =~ "screen" || &term =~ "rxvt"

  if &term =~ '256color'
      " disable Background Color Erase (BCE) so that color schemes
      " render properly when inside 256-color tmux and GNU screen.
      " see also http://sunaku.github.io/vim-256color-bce.html
      set t_ut=
  endif

endif

" up and down are using columns
nnoremap k gk
nnoremap j gj
nnoremap <up> gk
nnoremap <down> gj

" normal regexp
nnoremap / /\v
vnoremap / /\v

" going from bracket to bracket by pressing TAB
nnoremap <tab> %
vnoremap <tab> %

" autosave buffers when losing focus
au FocusLost * :wa

let maplocalleader=','        " all my macros start with ,

if has("syntax")
  syntax on
endif

if has('diff')
  set diffopt=filler        " insert filler to make lines match up
  set diffopt+=iwhite       " ignore all whitespace
endif

set showtabline=2
set diffopt+=vertical     " make :diffsplit default to vertical

if has('spell')
  " <F12> highlight spelling mistakes
  nmap <F12> :set spell!<CR>

  set sps=best
endif

" <F1> toggle hlsearch (highlight search matches).
nmap <F1> :set hls!<CR>

" <F2>: toggle list (display unprintable characters).
nnoremap <F2> :set list!<CR>

" toggle line numbers
map <F3> :set number!<CR>

" toggle syntax
" map <F4> :if exists("g:syntax_on") <bar> syntax off <bar> else <bar> syntax on <bar> endif<CR>

"set paste
"set relativenumber
" gpg stuff
nmap <F5> :set paste!<CR>
nmap <F6> :set relativenumber!<CR>
" nmap <F7> :% ! gpg --encrypt<CR>
" nmap a<F7> :% ! gpg -a --encrypt<CR>
" nmap <F8> :% ! gpg --decrypt<CR>

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
" map <C-t><left> :tabp<cr>
" map <C-t><right> :tabn<cr>

map <C-l> :tabnext<CR>
map <C-h> :tabprevious<CR>
map <C-T> :tabnew<CR>
map <C-W> :confirm bdelete<CR>
map <C-e> :tabnew<CR>
map <C-r> :tabdo
map <C-s> :vsplit<CR>
" tag backward
map <C-p> :pop<CR>

" folding
set fdm=marker

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" use ,ww to toggle line wrapping
nmap <LocalLeader>ww :set wrap! wrap?<cr>

" toggle paste mode.  Everything is inserted literally - no indending
set pastetoggle=<F11>

if has('autocmd') " {{{ 

  function! ResCur() " {{{
    if line("'\"") <= line("$")
      normal! g`"
      return 1
    endif
  endfunction " }}}

  function! StripTrailingCarriageReturn() " {{{
  " clean up the \r at the end of lines
    exec "normal ma" | " this saves the current position in the file
    %s/\r//e
    exec "normal `a" | " this restores the current position in the file
  endfunction " }}}

  function! StripTrailingWhitespace() " {{{
  " this function as the name suggests strips the trailing
  " white characters from the end of the lines
    exec "normal ma" | " this saves the current position in the file
    %s/\s\+$//e
    exec "normal `a" | " this restores the current position in the file
  endfunction " }}}

  function! ShowLineLimit() " {{{ 
    " warning for lines that are above 80 characters
    let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
    let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
  endfunction " }}}

  function! FileCleanUp() " {{{
    call StripTrailingCarriageReturn()
    call StripTrailingWhitespace()
    retab
  endfunction " }}}

  augroup ResCur " {{{
    au!
    au BufWinEnter * call ResCur()
  augroup END " }}}

  augroup Openssl-enc " {{{
    au!
    au BufNewFile,BufReadPre *.enc :set secure viminfo= noswapfile nobackup nowritebackup history=0
    au BufRead *.enc :% ! openssl enc -a -d -aes-256-cbc
    au BufWrite *.enc :% ! openssl enc -a -aes-256-cbc
  augroup END " }}}

  augroup Openssl-enc-bzip2 " {{{
    au!
    au BufNewFile,BufReadPre *.bz2enc :set secure viminfo= noswapfile nobackup nowritebackup history=0
    au BufRead *.bz2enc :% ! openssl enc -a -d -aes-256-cbc | bzip2 -d -c
    au BufWrite *.bz2enc :% ! bzip2 -c | openssl enc -a -aes-256-cbc
  augroup END " }}}

  augroup Makefile " {{{
    au!
    au BufRead Makefile :set noexpandtab
  augroup END " }}}

  " clean up trailing white spaces in my scripts
  au BufWrite $HOME/store/tools/* call FileCleanUp()
  "au BufRead,BufNewFile $HOME/store/tools/*.py call ShowLineLimit()

  " muttrc file syntax
  au BufRead,BufNewFile $HOME/.mutt/*.conf :set filetype=muttrc

  augroup VimConfig " {{{
    au!
    au BufWritePost ~/.vimrc so ~/.vimrc
  augroup END " }}}

endif " }}}

func! GitGrep(...) "{{{
  let grepsave = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = grepsave
endfun

command! -nargs=? G execute 'silent call GitGrep(<f-args>)' | cw | redraw!
nnoremap <C-F> :tab split<CR>:G <cword><CR>
"}}}

" local changes
if filereadable(expand("~/.vimrc.local"))
  so ~/.vimrc.local
endif

set secure
