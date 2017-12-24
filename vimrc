set nocompatible              " be iMproved, required
set shortmess=atI
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')
" common plugin
Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'kien/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

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

" for golang
Plug 'buoto/gotests-vim', {'for': 'go', 'on': 'GoTests'}   "auto generate unit testing
Plug 'fatih/vim-go', {'for': 'go', 'commit': '40e2e19'}

" for python
Plug 'tell-k/vim-autopep8', {'for': 'python', 'on': 'Autopep8'}

" for cmake
Plug 'richq/vim-cmake-completion', {'for': 'cmake'}
" for toml
Plug 'cespare/vim-toml', {'for': 'toml'}

" YcmCompleter help
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable', 'on': 'YcmGenerateConfig'}

" gruvbox theme
Plug 'morhetz/gruvbox'
" Initialize Plug system
call plug#end()

"tagbar config
let g:tagbar_width = 30
"Plugin Config start
"
"YouCompleteMe Config
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
if !empty($VIRTUAL_ENV)
    let g:ycm_python_binary_path = 'python'
else
    let g:ycm_python_binary_path = 'python3'
endif
let g:ycm_key_invoke_completion = '<C-a>'
let g:ycm_confirm_extra_conf = 0

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
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme = 'gruvbox'
set laststatus=2
set t_Co=256

" doxygenToolkit.vim config
let g:DoxygenToolkit_briefTag_pre="@Synopsis " 
let g:DoxygenToolkit_paramTag_pre="@Param " 
let g:DoxygenToolkit_returnTag="@Returns " 
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="weicheng <tomwei7@163.com>" 

" ale config
let g:ale_linters = {
            \   'python': ['flake8'],
            \   'go': ['golint', 'go build'],
            \   'c': [],
            \   'cpp': [],
            \}
let g:ale_python_flake8_options="--ignore=E501"
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
let g:ctrlp_regexp = 1

" vim beakpoint format to clipboard
function CopyAsBreakpoint()
    let s:pos=expand('%:p') . ':' . line('.')
    call setreg('+y', s:pos)
endfunction
command CopyAsBreak call CopyAsBreakpoint()

" vim-go config
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 1
let g:go_def_mapping_enabled = 0

" markdown config
let g:vim_markdown_folding_disabled = 1 "设置不做代码折叠

" NERDTree config
"function! NERDTreeToggleInCurDir()
"  " If NERDTree is open in the current buffer
"  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
"    exe ":NERDTreeClose"
"  else
"    exe ":NERDTreeFind"
"  endif
"endfunction
" Open NERDTree in the directory of the current file (or /home if no file is open)
"nmap <silent> <C-n> :call NERDTreeToggleInCurDir()<cr>

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['__pycache__', '\.pyc$[[file]]']

" terryma/vim-multiple-cursors config
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" UI config
if has('gui_running')
    set guifont=Menlo:h12
    " 清除macvim滚动条
    set guioptions-=gmrL
else
    if $ENABLE_ITALIC == 'true'
        let g:gruvbox_italic=1
    endif
endif

set background=dark
silent! colorscheme gruvbox
syntax enable
" reset background color
" hi Normal ctermbg=none
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
autocmd Filetype python setlocal colorcolumn=81

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

if $TERM_PROGRAM == 'iTerm.app'
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
