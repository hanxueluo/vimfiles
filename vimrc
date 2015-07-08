let g:isWindows = has('win32') || has('win64')

if g:isWindows
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set fencs=utf-8,GB18030,ucs-bom,default,latin1
    let g:Powerline_symbols = 'fancy'
    scriptencoding utf-8
    set t_Co=256
else
    runtime! debian.vim
    set t_Co=256
endif

set nocompatible
filetype off
if g:isWindows
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc()
    call vundle#begin('$VIM/vimfiles/bundle')
    Bundle 'Lokaltog/vim-powerline'
else
    set rtp+=/etc/vim/bundle/vundle/
    call vundle#rc()
    call vundle#begin('/etc/vim/bundle')
    Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
    Bundle 'Valloric/YouCompleteMe'
endif
    Bundle 'gmarik/vundle'
    Bundle 'vim-scripts/Conque-Shell'
    Bundle 'kien/ctrlp.vim'
    Bundle 'vim-scripts/matrix.vim--Yang'
    Bundle 'fholgado/minibufexpl.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'majutsushi/tagbar'
    Bundle 'godlygeek/tabular'
    Bundle 'tpope/vim-fugitive'
    Bundle 'MattesGroeger/vim-bookmarks'

    Bundle 'L9'
    Bundle 'Lokaltog/vim-easymotion'

    Bundle 'CCTree'
    Bundle 'colorselector'
    Bundle 'FuzzyFinder'
    Bundle 'wesleyche/SrcExpl'
    "Bundle 'vim-scripts/mark'
    Bundle 'mbriggs/mark.vim'
    Bundle 'vim-scripts/a.vim'
    Bundle 'vim-scripts/showhide.vim'

    Bundle 'msanders/snipmate.vim'
call vundle#end()
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nobackup
set nowrap
set hlsearch
set nu!
set cursorline
set tags=tags
"set encoding=utf-8
set laststatus=2
au FileType make setlocal noexpandtab
au BufRead,BufNewFile *.am setlocal noexpandtab

syntax enable
syntax on

if filereadable("cscope.out")
    cs add cscope.out
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
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
    nmap <F5> :!%<CR>

    filetype plugin indent on
    colorscheme evening
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
    nmap <F5> :!./%<CR>
    nmap <F6> :make<CR>
    colorscheme slate
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    let g:CCTreeKeyTraceForwardTree = '<Leader>.'
    let g:CCTreeKeyTraceReverseTree = '<Leader>,'
    let g:CCTreeKeyToggleWindow = 'wc'
endif

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
let NERDTreeIgnore = ['\.o$', '\~$']

let g:bookmark_sign = '☆'
let g:bookmark_annotation_sign = '★'

"ino  <c-m> <c-r>=TriggerSnippet()<cr>
"snor <c-m> <esc>i<right><c-r>=TriggerSnippet()<cr>

" Press 'p' to do the quickfix preview
function! s:QuickfixPreview()
    let l:quickfixwinnr = winnr()
    execute "normal! \<CR>"
    execute l:quickfixwinnr . 'wincmd w'
endfunction
autocmd BufReadPost quickfix nmap <buffer> p :call <SID>QuickfixPreview()<CR>
