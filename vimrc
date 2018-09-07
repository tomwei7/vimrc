set nocompatible              " be iMproved, required
set shortmess=atI
set backspace=indent,eol,start
" ignore python 3.7 imp module is deprecated warning
if has('python3')
  silent! python3 1
endif

" tvim default configure
let g:tvim_powerline_fonts=0
let g:tvim_italic=0
let g:tvim_icon=1
let g:tvim_features=[]
let g:tvim_all_features=0
let g:tvim_change_cursor=0

" load user config
if !empty(glob('~/.vim/config.vim'))
    source ~/.vim/config.vim
endif

" load plugin
if !empty(glob('~/.vim/plugin.vim'))
    source ~/.vim/plugin.vim
end

" highlight current line
set cursorline
" fast renderer
set lazyredraw
set ttyfast
" show line number
set number
" set indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
" use space instead of tab
set expandtab
" disable backup file
set nobackup
" disable swapfile
set noswapfile
" search config
set ignorecase
set smartcase
set incsearch
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
" show invisible char
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set maxmempattern=10240
set wildmenu

syntax enable
set background=dark
silent! colorscheme tender
filetype indent plugin on

" UI config
set laststatus=2
"set t_Co=256
if has('gui_running')
    set guifont=SF\ Mono\ Regular\ Nerd\ Font\ Complete:h13
    " 清除macvim滚动条
    set guioptions-=gmrL
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" 解决有时候打开文件需要按 enter 的问题 http://vimhelp.appspot.com/options.txt.html#%27shortmess%27
set shortmess=Ot
" ignore venv and vendor
set wildignore+=venv/**,vendor/**
set foldlevelstart=10
set foldmethod=syntax
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

let mapleader=","
map <Leader>v  :set list!<CR>
map <Leader>p  :bp<CR>
map <Leader>n :bn<CR>

" different indent
autocmd Filetype html,htmldjango,css,ruby,javascript,json,yaml,vue  setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal colorcolumn=121
autocmd Filetype vim setlocal foldmethod=marker
autocmd Filetype go setlocal noexpandtab

" file template
autocmd BufNewFile *.py silent! 0r ~/.vim/template/simple.py 
autocmd BufNewFile *.php silent! 0r ~/.vim/template/simple.php 
autocmd BufNewFile *.sh silent! 0r ~/.vim/template/simple.sh 
autocmd BufNewFile *.go silent! 0r ~/.vim/template/simple.go

" fix filetype
autocmd BufNewFile,BufRead *.cl set filetype=opencl
autocmd BufNewFile,BufRead *.vs,*.fs set ft=glsl

" tern
autocmd BufNewFile,BufRead .tern-project setf json
autocmd BufNewFile,BufRead .tern-config setf json
autocmd BufNewFile,BufRead global_ycm_extra_conf.py setlocal ts=2 sts=2 sw=2

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm" && !has('nvim') && g:tvim_change_cursor
    let &t_SI="\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI="\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    let &t_SR="\<Esc>]50;CursorShape=2\x7"
endif

" vim beakpoint format to clipboard
function CopyAsBreakpoint()
    let s:pos=expand('%:p') . ':' . line('.')
    call setreg('+y', s:pos)
endfunction
command CopyAsBreak call CopyAsBreakpoint()

if executable('jsontool')
    command JsonFormat execute "%!jsontool"
else
    command JsonFormat execute "%!python -m json.tool"
endif
