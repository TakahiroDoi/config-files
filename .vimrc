" History 
" 2020-04-02 (Thu) add white 

if 1 
" Pathogen
" 2016-05-23 (Taka Doi)
execute pathogen#infect()

" solarized color scheme
" 2016-05-23 (Taka Doi)
syntax enable
set term=xterm-256color
set t_Co=256
let g:solarized_termcolors = 256

" set the value below to 1 for dark background (dark mode)
" set the value below to 0 for bright backgorund (light mode)
let g:solarized_termtrans  = 1     
" let g:solarized_termtrans  = 0     

set background=dark 
" "set background=light

" Make brighter Comment and Normal color
" (Comment out these lines for light mode use)
" autocmd ColorScheme * highlight Comment ctermfg=242 guifg=#008800
" autocmd ColorScheme * highlight Normal  ctermfg=248 guifg=#008800

" Use outside 
" white 
" autocmd ColorScheme * highlight Normal  ctermfg=15 guifg=#ffffff


colorscheme solarized

"Add full file path to your existing statusline"
" change F to f if you prefer the relative path
set statusline+=%f

" An example for a vimrc file. copied roma file according to vimtutor by Taka
" Doi
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" Taka Doi
" close parenthesisi
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap [ []<Esc>i

" set number
set number

" completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" change visual mode color to curcorline color
highlight! link Visual CursorLine

" yank something to system clipboard
" enabling this prevent even a normal yank from working under tmux (2016-08-03)
" the issue remains even when I enabled reattach-to-user-namespace and
" enabled pbpaste in tmux
" (2017-07-03)
" set clipboard=unnamed

" https://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
" if $TMUX == ''
"    set clipboard+=unnamed
" endif

"Tab setting for python
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

"Tab setting for css
autocmd FileType css set sw=4
autocmd FileType css set ts=4
autocmd FileType css set sts=4

"Settings for YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

"Recommended settings for Syntastic 
"https://github.com/scrooloose/syntastic#installation
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"For now, let's disable HTML checkers for Syntastic
let g:syntastic_html_checkers = []


"Opens search results in a window w/ links and highlight the matches
" http://chase-seibert.github.io/blog/2013/09/21/vim-grep-under-cursor.html
" :Grep searchword, :Grep "\<searchword\>", \g with the cursor on a word 
command! -nargs=+ Grep execute 'silent grep! -I -r -n --exclude *.{json,pyc,c~,d~,py~,h~} . -e <args>' | copen | execute 'silent /<args>'
" shift-control-* Greps for the word under the cursor
nmap <leader>g :Grep <c-r>=expand("<cword>")<cr><cr>


"Buffegator settings"
" http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
"use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>


" Ctr-P
" http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
set runtimepath^=~/.vim/bundle/ctrlp.vim

"setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" CtrlP 
" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>
" Default Most Recent Update
let g:ctrlp_cmd = 'CtrlPMRU'

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>


set pastetoggle=<leader>o
set expandtab


"replace the word under cursor"
nnoremap <Leader>d :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>f :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <Leader>a :.s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>s :.s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>

"get file name and path to the unamed register"
" note that * indicates the system clipboard on mac osx 
nmap cfn :let @* = expand("%:t")
nmap cfp :let @* = expand("%:p")

" to insert filenames and paths
" the two lines below significantly delays yank/paste. not sure why...
":nmap pfn :put = expand('%:t')
":nmap pfp :put = expand('%:p')

" insert the full path to the current script 
" press /fn in the insert mode 
" not working under tmux 
inoremap <leader>fn <C-R>=expand("%:p:h")<CR>

" keyboard shortcut for matlab
" ,l to insert something
map ,m opdb.set_trace()<ESC>x
" ,a to insert my assert_ line 
map ,a oassert_(expr,[mfn,emsg]); clear expr emsg;<ESC>lxx
" ,f to insert my matlab input variable check 
map ,f oif~exist('variableName','var')isempty(variableName); variableName = 1; end<ESC>lxxxxxxDad



" to suppress an error that resulted from the line above... 
set shortmess+=c

" insert space from normal mode
" Now you can do 10 <space>
nnoremap <space> i<space><ESC>

" insert date 
nnoremap <leader>t "=strftime(" %F (%a)")<CR>P
inoremap <leader>t <C-R>=strftime(" %F (%a)")<CR>

" insert tab from noarmla mode     
" Do not do this because setting tab disables Ctrl+I
" "nnoremap <tab> i<tab><ESC>

"vim-bufsurf
nmap :bp :BufSurfBack<cr>
nmap :bn :BufSurfForward<cr>


"vim-easy-align"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"cursor size
set guicursor+=i:ver100-iCursor
""highlight Cursor guifg=white guibg=black
""highlight iCursor guifg=white guibg=steelblue
""set guicursor=n-v-c:block-Cursor
""""set guicursor+=n-v-c:blinkon0
""""set guicursor+=i:blinkwait10

" Enable CursorLine
set cursorline 

" Default Colors for CursorLine
highlight  CursorLine ctermbg=None ctermfg=None
highlight  CursorLineNR ctermbg=None ctermfg=Grey
" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLineNR ctermfg=Grey
" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLineNR ctermfg=Blue

" visual mode color
hi Visual  guifg=#000000 guibg=#FFFFFF gui=none

" Didn't work...
" molokai cursor  
" Visual Mode Orange Background, Black Text
"hi Visual          guifg=#000000 guibg=#FD971F

" Default Colors for CursorLine
"highlight CursorLine guibg=#3E3D32
"highlight Cursor guibg=#A6E22E;

" Change Color when entering Insert Mode
"autocmd InsertEnter * highlight  CursorLine guibg=#323D3E
"autocmd InsertEnter * highlight  Cursor guibg=#00AAFF;

" Revert Color to default when leaving Insert Mode
"autocmd InsertLeave * highlight  CursorLine guibg=#3E3D32
"autocmd InsertLeave * highlight  Cursor guibg=#A6E22E;

"spell check for md files
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us

" disable all bells
set belloff=all

" to use a preview for md 
let vim_markdown_preview_github=1

endif

" : is not necessary at the head of the line  
