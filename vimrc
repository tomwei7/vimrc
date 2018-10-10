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
let g:tvim_icon=0
let g:tvim_features=[]
let g:tvim_all_features=0
let g:tvim_change_cursor=0

" load user config
if !empty(glob('~/.vim/config.vim'))
    source ~/.vim/config.vim
endif

" vim-plug config A minimalist Vim plugin manager.
" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'godlygeek/tabular'
Plug 'Yggdroot/LeaderF', {'do': './install.sh', 'on': ['LeaderfFile', 'LeaderfBuffer', 'LeaderfFunction', 'LeaderfBufTag', 'LeaderfBufTagAll']}
Plug 'wincent/ferret', {'on': 'Ack'}
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'

if count(g:tvim_features, 'lint') || g:tvim_all_features
    Plug 'w0rp/ale'
endif

if count(g:tvim_features, 'git') || g:tvim_all_features
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
endif

if count(g:tvim_features, 'markdown') || g:tvim_all_features
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
    Plug 'kannokanno/previm', {'for': 'markdown'}
endif

if count(g:tvim_features, 'indentline') || g:tvim_all_features
    " Let indentLine use current conceal options
    let g:indentLine_conceallevel  = &conceallevel
    let g:indentLine_concealcursor = &concealcursor
    Plug 'yggdroot/indentline'
endif

if count(g:tvim_features, 'python') || g:tvim_all_features
    Plug 'tell-k/vim-autopep8', {'for': 'python', 'on': 'Autopep8'}
endif

if count(g:tvim_features, 'web') || g:tvim_all_features
    Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'htmldjango']}
    Plug 'pangloss/vim-javascript', {'for': 'javascript'}
    Plug 'posva/vim-vue', {'for': 'vue'}
endif

if count(g:tvim_features, 'go') || g:tvim_all_features
    " for golang
    Plug 'buoto/gotests-vim', {'for': 'go', 'on': 'GoTests'}   "auto generate unit testing
    Plug 'fatih/vim-go', {'for': 'go'}
endif

if count(g:tvim_features, 'c-family') || g:tvim_all_features
    Plug 'richq/vim-cmake-completion', {'for': 'cmake'}
    Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp']}
    Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
endif

if count(g:tvim_features, 'ultisnips') || g:tvim_all_features
    " snippets
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
endif

if count(g:tvim_features, 'ycm') || g:tvim_all_features
    " YouCompleteMe
    Plug 'Valloric/YouCompleteMe'
    " YcmCompleter help
    Plug 'rdnetto/YCM-Generator', {'branch': 'stable', 'on': 'YcmGenerateConfig'}
endif

if count(g:tvim_features, 'icons') || g:tvim_all_features
    Plug 'ryanoasis/vim-devicons'
endif
" Initialize Plug system
call plug#end()

""" ultisnips {{{
if has_key(g:plugs, 'ultisnips')
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-x>"
    let g:UltiSnipsSnippetDirectories=["ultisnips"]
endif
"}}}

""" DoxygenToolkit {{{
    let g:DoxygenToolkit_briefTag_pre="@Synopsis " 
    let g:DoxygenToolkit_paramTag_pre="@Param " 
    let g:DoxygenToolkit_returnTag="@Returns " 
    let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
    let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------" 
    let g:DoxygenToolkit_authorName="weicheng <tomwei7@163.com>" 
"}}}

""" ale {{{
if has_key(g:plugs, 'ale') 
    let g:ale_linters={
                \   'python': ['flake8'],
                \   'go': ['golint', 'go build'],
                \   'c': [],
                \   'cpp': [],
                \   'proto': [],
                \   'js': [],
                \}
    let g:ale_python_flake8_options="--ignore=E501"
    let g:ale_lint_on_text_changed='never'
    let g:ale_lint_on_enter=0
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
endif
"}}}

""" YcmCompleter {{{
let g:ycm_global_ycm_extra_conf='~/.vim/global_ycm_extra_conf.py'
if !empty($VIRTUAL_ENV)
    let g:ycm_python_binary_path='python'
else
    let g:ycm_python_binary_path='python3'
endif
let g:ycm_key_invoke_completion='<C-a>'
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_insertion=0
let g:ycm_gocode_binary_path='/Users/weicheng/go/bin/gocode'
let g:ycm_godef_binary_path='/Users/weicheng/go/bin/godef'
nmap gd :YcmCompleter GoToDefinition <CR>
"}}}

""" tagbar {{{
let g:tagbar_width=30
"}}}

""" vim-go {{{
" vim-go config
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_fields=1
let g:go_highlight_types=1
let g:go_highlight_operators=1
let g:go_highlight_build_constraints=1
let g:go_list_type="quickfix"
let g:go_fmt_autosave=1
let g:go_def_mapping_enabled=0
let g:go_get_update=1
" }}}

""" markdown {{{
let g:vim_markdown_folding_disabled=1 "设置不做代码折叠
"}}}

""" autopep8 {{{
let g:autopep8_disable_show_diff=1
"}}}

""" LeaderF {{{
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_WindowHeight = 0.30
if g:tvim_powerline_fonts
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
else
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
end
command LF :LeaderfFunction
command LB :LeaderfBuffer
command LT :LeaderfBufTag
command LAT :LeaderfBufTagAll
map <C-p> :LeaderfFile<CR>
"}}}

""" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>
command DFind :NERDTreeFind
let g:NERDTreeIgnore = ['__pycache__', '\.pyc$[[file]]', '^bazel-*']
"}}}

""" previm {{{
let g:previm_open_cmd = 'open -a Google\ Chrome'
"}}}

""" gruvbox {{{
let g:gruvbox_italic = g:tvim_italic
"}}}

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
silent! colorscheme base16-default-dark
filetype indent plugin on

" UI config
set laststatus=2
"set t_Co=256
if has('gui_running')
    set guifont=SF\ Mono\ Regular\ Nerd\ Font\ Complete:h14
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

"let mapleader=","
map <Leader>v :set list!<CR>
map <Leader>p :bp<CR>
map <Leader>n :bn<CR>
map <Leader>t :LeaderfBufTag<CR>

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
