set nocompatible              " be iMproved, required
set shortmess=atI
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')
" common plugin
Plug 'bling/vim-airline'
Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'godlygeek/tabular'
"Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" Load on nothing
"Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'SirVer/ultisnips'
"Plug 'Valloric/YouCompleteMe', { 'on': 'YcmCompleter' }
Plug 'Valloric/YouCompleteMe'
" YcmCompleter help
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable', 'on': 'YcmGenerateConfig'}
" for front end
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'htmldjango']}
" for javascript
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
" for vue
Plug 'posva/vim-vue', {'for': 'vue'}
" for c, cpp
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp']}
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
" for markdown
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'kannokanno/previm', {'for': 'markdown'}
" for golang
Plug 'buoto/gotests-vim', {'for': 'go', 'on': 'GoTests'}   "auto generate unit testing
Plug 'fatih/vim-go', {'for': 'go'}
" for python
Plug 'tell-k/vim-autopep8', {'for': 'python', 'on': 'Autopep8'}
" for cmake
Plug 'richq/vim-cmake-completion', {'for': 'cmake'}
" for toml
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
" Initialize Plug system
call plug#end()

"tagbar config
let g:tagbar_width=30

"YouCompleteMe Config
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
if !empty($VIRTUAL_ENV)
    let g:ycm_python_binary_path='python'
else
    let g:ycm_python_binary_path='python3'
endif
let g:ycm_key_invoke_completion='<C-a>'
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_insertion=1

nmap gd :YcmCompleter GoToDefinition <CR>

"离开插入模式后自动关闭预览窗口
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif	

" UltiSnips Config
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-x>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" airline config
let g:airline_theme='onedark'

" doxygenToolkit.vim config
let g:DoxygenToolkit_briefTag_pre="@Synopsis " 
let g:DoxygenToolkit_paramTag_pre="@Param " 
let g:DoxygenToolkit_returnTag="@Returns " 
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="weicheng <tomwei7@163.com>" 

" ale config
let g:ale_linters={
            \   'python': ['flake8'],
            \   'go': ['golint', 'go build'],
            \   'c': [],
            \   'cpp': [],
            \   'proto': [],
            \}
let g:ale_python_flake8_options="--ignore=E501"
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ctrlp
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching=0
endif
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
let g:ctrlp_regexp=1

" vim beakpoint format to clipboard
function CopyAsBreakpoint()
    let s:pos=expand('%:p') . ':' . line('.')
    call setreg('+y', s:pos)
endfunction
command CopyAsBreak call CopyAsBreakpoint()

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

" autopep8
let g:autopep8_disable_show_diff=1

" markdown config
let g:vim_markdown_folding_disabled=1 "设置不做代码折叠

" previm config
let g:previm_open_cmd = 'open -a Google\ Chrome'

map <C-n> :NERDTreeToggle<CR>
command DFind :NERDTreeFind
let g:NERDTreeIgnore=['__pycache__', '\.pyc$[[file]]']

" terryma/vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key     ='<C-n>'
let g:multi_cursor_select_all_word_key='<C-m><C-n>'
let g:multi_cursor_start_key          ='g<C-n>'
let g:multi_cursor_select_all_key     ='g<C-m><C-n>'
let g:multi_cursor_next_key           ='<C-n>'
let g:multi_cursor_prev_key           ='<C-p>'
let g:multi_cursor_skip_key           ='<C-x>'
let g:multi_cursor_quit_key           ='<Esc>'

" UI config
set laststatus=2
set t_Co=256
if has('gui_running')
    set guifont=Menlo:h14
    " 清除macvim滚动条
    set guioptions-=gmrL
endif

set background=dark

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

let g:onedark_terminal_italics=1
syntax enable
silent! colorscheme onedark
filetype indent plugin on

" reset background color
"hi Normal ctermbg=none
" 高亮当前行
set cursorline
highlight clear SignColumn

"编辑器设置
set nu
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 空格代替制表符
set expandtab
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set smartcase
set ignorecase

" 编码支持
set fileencodings=utf-8,gb18030,gbk,gb2312,big5

" 设置不可见字符
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" 不同文件缩进
autocmd Filetype html,htmldjango,css,ruby,javascript,json,yaml,vue  setlocal ts=2 sts=2 sw=2

" 每行最大字符数
autocmd Filetype python setlocal colorcolumn=121

" 模板
autocmd BufNewFile *.py silent! 0r ~/.vim/template/simple.py 
autocmd BufNewFile *.php silent! 0r ~/.vim/template/simple.php 
autocmd BufNewFile *.sh silent! 0r ~/.vim/template/simple.sh 
autocmd BufNewFile *.go silent! 0r ~/.vim/template/simple.go

" 快捷键设置
map <F8>  :set list!<CR>
map <F9>  :bp<CR>
map <F10> :bn<CR>

" 勘误
command W w
command Q q

" tern
au BufNewFile,BufRead .tern-project setf json
au BufNewFile,BufRead .tern-config setf json

" build设置
" python
au Filetype python map <buffer> <F5> :!time /usr/bin/env python % <CR>
" go
au Filetype go map <buffer> <F5> :!time go run % <CR>
" bash
au Filetype sh map <buffer> <F5> :!bash % <CR>

command JsonFormat execute "%!python -m json.tool"

" 解决有时候打开文件需要按 enter 的问题 http://vimhelp.appspot.com/options.txt.html#%27shortmess%27
set shortmess=Ot

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" ignore venv and vendor
set wildignore+=venv/**,vendor/**

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI="\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI="\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    let &t_SR="\<Esc>]50;CursorShape=2\x7"
endif
autocmd BufNewFile,BufRead *.cl set filetype=opencl
autocmd BufNewFile,BufRead *.vs,*.fs set ft=glsl
