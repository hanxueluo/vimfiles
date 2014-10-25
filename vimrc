" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
set hlsearch		
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

colorscheme slate
syntax enable
syntax on
set nobackup
set nu!
call pathogen#infect()

let g:miniBufExplMapWindowsNavVim=1
let g:miniBufExplMapCTabSwitchBufs=1
"let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplUseSingleClick=1
let g:miniBufExplTabWrap=1
let g:miniBufExplCycleArround=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Update=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
"nnoremap <silent> <F8> :TlistToggle<CR>

set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <leader>w :WMToggle<cr>
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nnoremap <silent> <F12> :A<CR>

"
noremap <C-n> :MBEbn<CR>
noremap <C-p> :MBEbp<CR>
nmap <unique> <silent> <F3> <Plug>LookupFile
imap <unique> <silent> <F3> <C-O><Plug>LookupFile

nmap <C-S-K> :bd<CR>
"run current file
nmap <F5> :!./%<CR>
"for python dictionary
filetype plugin on
"let g:pydiction_location=$VIMRUNTIME . '/tools/pydiction/complete-dict'

filetype plugin indent on
