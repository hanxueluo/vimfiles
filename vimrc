let g:isWindows = has('win32') || has('win64')

source $VIMRUNTIME/vimrc_example.vim
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,default,latin1
if g:isWindows
    " set shell in case of that gvim starts from bash in windows
    set shell=cmd.exe
    set shellcmdflag=/c
    "source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    scriptencoding utf-8
    set t_Co=256
else
    if &ttymouse == 'xterm2'
        set t_Co=256
    endif
    runtime! debian.vim
    set mouse=
    " fix default errorformat miss match when build ovs 2.5
    autocmd FileType c compiler gcc
endif
if v:version >= 703
    set noundofile
endif

set nocompatible
filetype off
if g:isWindows
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc()
    call vundle#begin('$VIM/vimfiles/bundle')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#rc()
    call vundle#begin()
    Bundle 'Valloric/YouCompleteMe'
endif
    Bundle 'vim-airline/vim-airline'
    Bundle 'mileszs/ack.vim'
    Bundle 'rking/ag.vim'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'spf13/vim-colors'
    Bundle 'Townk/vim-autoclose'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-repeat'
    Plugin 'VundleVim/Vundle.vim'
    Bundle 'vim-scripts/Conque-Shell'
    Bundle 'ctrlpvim/ctrlp.vim'
    Bundle 'fholgado/minibufexpl.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'majutsushi/tagbar'
    Bundle 'godlygeek/tabular'
    Bundle 'tpope/vim-fugitive'
    Bundle 'MattesGroeger/vim-bookmarks'

    Bundle 'L9'
    Bundle 'Lokaltog/vim-easymotion'

    Bundle 'CCTree'
    Bundle 'FuzzyFinder'
    Bundle 'wesleyche/SrcExpl'
    "Bundle 'vim-scripts/mark'
    Bundle 'mbriggs/mark.vim'
    Bundle 'vim-scripts/a.vim'
    Bundle 'vim-scripts/showhide.vim'

    Bundle 'msanders/snipmate.vim'
    Bundle 'hanxueluo/vim-togglequickfix'
call vundle#end()
filetype plugin indent on
"let g:airline#extensions#tabline#enabled = 1
let g:multi_cursor_exit_from_insert_mode = 0
let g:AutoClosePumvisible = {"ENTER": "", "ESC": ""}

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nobackup
set noswapfile
set nowrap
set hlsearch
set nu!
set tags=tags
"set encoding=utf-8
set laststatus=2

let mapleader=","
au FileType make setlocal noexpandtab
"au FileType xml  setlocal equalprg=xmllint\ --exc-c14n\ --format\ -
au BufRead,BufNewFile *.am setlocal noexpandtab

syntax enable
syntax on

if filereadable("cscope.out")
    cscope add cscope.out
elseif $CSCOPE_DB != ""
    cscope add $CSCOPE_DB
endif

let g:ctrlp_match_window='top,order:ttb'
let g:go_fmt_autosave =1
let g:miniBufExplCycleArround=1
let g:miniBufExplMapWindowsNavVim=1
let g:miniBufExplMapCTabSwitchBufs=1
"let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplUseSingleClick=1
let g:miniBufExplTabWrap=1

set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <F5> :!"%:p"<CR>
nnoremap <silent> <F12> :A<CR>
nnoremap <silent> <F3> :CtrlP<CR>
nnoremap <silent> <F8> :CtrlPBufTag<CR>
nnoremap <silent> <F7> :CtrlPTag<CR>
noremap  <silent> <C-j>   :MBEbp<CR>
noremap  <silent> <C-k>   :MBEbn<CR>

nmap wn :NERDTreeToggle<CR>
nmap wm :TagbarToggle<CR>
nmap wp :SrcExplToggle<CR>
nmap wq :copen<CR>
nmap wl :lopen<CR>

nmap <silent> qq :q<CR>
nmap <silent> qa :qa<CR>
nmap <silent> q1 :q!<CR>

imap <C-D> <DEL>

if g:isWindows

    filetype plugin indent on
    "colorscheme slate
    "colorscheme evening
    set background=dark
    colorscheme solarized
    set diffexpr=MyDiff()
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
else
    nmap <F6> :make<CR>
    "set background=light
    "colorscheme solarized
    colorscheme slate
    "colorscheme evening
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    let g:CCTreeKeyTraceForwardTree = '<Leader>.'
    let g:CCTreeKeyTraceReverseTree = '<Leader>,'
    let g:CCTreeKeyToggleWindow = 'wc'
endif
" set cursorline after colorscheme
set cursorline
highlight CursorLine cterm=reverse ctermbg=0 term=bold
set cursorcolumn
highlight CursorColumn cterm=bold term=bold

nmap <Leader>' :exec 'lvimgrep /' . input('/', expand('<cword>')) . '/j % <bar> lopen'<CR>
"autocmd FileType log set guifont=Consolas:h8

nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <F2> <Plug>MarkSet
vmap <unique> <silent> <F2> <Plug>MarkSet
nmap <unique> <silent> <C-S-0> <Plug>MarkClear
let NERDTreeIgnore = ['\.o$', '\~$']

let g:bookmark_sign = '☆'
let g:bookmark_annotation_sign = '★'

"ino  <c-m> <c-r>=TriggerSnippet()<cr>
"snor <c-m> <esc>i<right><c-r>=TriggerSnippet()<cr>

" Press 'p' to do the quickfix preview
function! s:QuickfixPreview()
    let l:supportwinid = exists("*win_getid")
    if l:supportwinid
        let l:quickfixwinnr = win_getid()
    else
        let l:quickfixwinnr = winnr()
    endif
    execute "normal! \<CR>"
    if l:supportwinid
        call win_gotoid(l:quickfixwinnr)
    else
        execute l:quickfixwinnr . 'wincmd w'
    endif
endfunction
autocmd BufReadPost quickfix nmap <buffer> p :call <SID>QuickfixPreview()<CR>


set wildmenu
set so=3
set wildignore=*.o,*~,*.pyc
if has('gui_running') 
    "set winaltkeys=no
    nmap <silent><m-j> mz:m+<cr>`z
    nmap <silent><m-k> mz:m-2<cr>`z
    vmap <silent><m-j> :m'>+<cr>`<my`>mzgv`yo`z
    vmap <silent><m-k> :m'<-2<cr>`>my`<mzgv`yo`z
endif

set ruler
"set viminfo^=%
map <silent> <leader><cr> :noh<cr>
map <leader>sp :setlocal spell!<cr>
" ]s [s zg zw z=

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

vnoremap <silent> gv :call VisualSelection('gv')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


