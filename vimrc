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
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
" colortheme
Plug 'rakr/vim-one'

if count(g:tvim_features, 'ctrlp') || g:tvim_all_features
    Plug 'Yggdroot/LeaderF', {'do': './install.sh', 'on': ['LeaderfFile', 'LeaderfBuffer', 'LeaderfFunction', 'LeaderfBufTag', 'LeaderfBufTagAll']}
endif

if count(g:tvim_features, 'lint') || g:tvim_all_features
    Plug 'w0rp/ale'
    let g:ale_fixers = {}
    let g:ale_fixers.typescript = ['tslint']
    let g:ale_fixers.javascript = ['eslint']
endif

if count(g:tvim_features, 'git') || g:tvim_all_features
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
endif

if count(g:tvim_features, 'markdown') || g:tvim_all_features
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
    Plug 'kannokanno/previm', {'for': 'markdown'}
endif

if count(g:tvim_features, 'python') || g:tvim_all_features
    Plug 'tell-k/vim-autopep8', {'for': 'python', 'on': 'Autopep8'}
endif

if count(g:tvim_features, 'web') || g:tvim_all_features
    Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'htmldjango']}
    Plug 'pangloss/vim-javascript', {'for': 'javascript'}
    Plug 'posva/vim-vue', {'for': 'vue'}
    Plug 'mxw/vim-jsx', {'for': 'jsx'}
    Plug 'leafgarland/typescript-vim', {'for': ['tsx', 'typescript']}
    Plug 'peitalin/vim-jsx-typescript', {'for': 'tsx'}
endif

if count(g:tvim_features, 'go') || g:tvim_all_features
    " for golang
    Plug 'buoto/gotests-vim', {'for': 'go', 'on': 'GoTests'}   "auto generate unit testing
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'cespare/vim-toml', {'for': 'toml'}
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

" Initialize Plug system
call plug#end()

""" airline{{{
let g:airline_theme='one'
"""}}}

""" polyglot{{{
let g:polyglot_disabled = ['vue', 'javascript', 'typescript', 'jsx', 'tsx']
"""}}}

""" indentLine {{{
    let g:indentLine_fileTypeExclude = ['tex', 'markdown']
""" }}}

""" LeaderF {{{
map <C-p> :LeaderfFile<CR>
let g:Lf_WindowHeight = 0.30
if g:tvim_powerline_fonts
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
else
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
end
let g:Lf_StlColorscheme = 'one'
"}}}

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

""" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>
command DFind :NERDTreeFind
let g:NERDTreeIgnore = ['__pycache__', '\.pyc$[[file]]', '^bazel-*']
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
"}}}

""" previm {{{
let g:previm_open_cmd = 'open -a Google\ Chrome'
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
set laststatus=2
set t_Co=256
set background=dark

colorscheme one
set background=dark " for the dark version
" UI config
if has('gui_running')
    " 清除macvim滚动条
    set guifont=FuraMonoNerdFontCompleteM-Medium:h14
    set guioptions-=gmrL
endif
filetype indent plugin on


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
"set foldlevelstart=10
"set foldmethod=syntax
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

"let mapleader=","
map <Leader>v :set list!<CR>
map <Leader>p :bp<CR>
map <Leader>n :bn<CR>
map <Leader>t :LeaderfBufTag<CR>
map <Leader>f :LeaderfFunction<CR>

" different indent
autocmd Filetype html,htmldjango,css,ruby,javascript,json,yaml,vue,typescript,jsx,tsx,proto  setlocal ts=2 sts=2 sw=2
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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif
let macvim_skip_colorscheme=1
