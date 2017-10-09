syntax enable
set nocompatible              " be iMproved, required
set shortmess=atI
set backspace=indent,eol,start
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Airline: 状态栏
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" NERDtree: 文件浏览器
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'kien/ctrlp.vim'

"code snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"colorschemes
"Plug 'flazz/vim-colorschemes'
Plug 'tomasr/molokai'

"git
Plug 'tpope/vim-fugitive'

Plug 'Valloric/YouCompleteMe'
Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'htmldjango']}

Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp']}
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}

"golang
Plug 'buoto/gotests-vim', {'for': 'go'}   "自动生成单元测试
Plug 'fatih/vim-go', {'for': 'go'}

"javascript
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'posva/vim-vue', {'for': 'vue'}

"cmake
Plug 'richq/vim-cmake-completion', {'for': 'cmake'}
"toml
Plug 'cespare/vim-toml', {'for': 'toml'}

Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'majutsushi/tagbar'
" Initialize Plug system
call plug#end()

"tagbar config
let g:tagbar_width = 30
"Plugin Config start
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

"airline config
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme = 'base16_colors'
set laststatus=2
set t_Co=256

"DoxygenToolkit.vim config
let g:DoxygenToolkit_briefTag_pre="@Synopsis " 
let g:DoxygenToolkit_paramTag_pre="@Param " 
let g:DoxygenToolkit_returnTag="@Returns " 
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="weicheng <tomwei7@163.com>" 

let g:syntastic_python_flake8_args="--ignore=E501"
let g:syntastic_python_checkers=['flake8']
let g:syntastic_go_checkers=['golint']
let g:syntastic_enable_html_checker=0
"let py_version=system("python --version")
"if has('python')
"    if matchstr(py_version, 'Python 2') != ''
"        let g:syntastic_python_flake8_exec="/usr/local/bin/python -m flake8"
"    elseif matchstr(py_version, 'Python 3') != ''
"        let g:syntastic_python_flake8_exec="/usr/local/bin/python3 -m flake8"
"    endif
"endif
"
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
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_regexp = 1

" 清除macvim滚动条
if has('gui')
    set guioptions-=gmrL
endif
"let g:solarized_termcolors=256
"theme config
"colorscheme desert
let g:molokai_original = 1
let g:rehash256 = 1
silent! colorscheme molokai
"hack molokai
hi PreProc cterm=bold


"vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 1
let g:go_def_mapping_enabled = 1

"markdown
let g:vim_markdown_folding_disabled = 1 "设置不做代码折叠

"NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['__pycache__']

"terryma/vim-multiple-cursors
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


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
set ignorecase
"编码支持
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
"高亮当前行
set cursorline
highlight clear SignColumn
"hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE
"hi Normal ctermbg=NONE
"自动补全括号
"inoremap (  ()<left>
"inoremap [ []<left>
"inoremap " ""<left>
"inoremap ' ''<left>
"设置不可见字符
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" gui
set guifont=Menlo:h13

"不同文件缩进
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2

"每行最大字符数
autocmd Filetype python setlocal colorcolumn=81
autocmd Filetype php setlocal colorcolumn=121

"模板
autocmd BufNewFile *.py silent! 0r ~/.vim/template/simple.py 
autocmd BufNewFile *.php silent! 0r ~/.vim/template/simple.php 
autocmd BufNewFile *.sh silent! 0r ~/.vim/template/simple.sh 
autocmd BufNewFile *.go silent! 0r ~/.vim/template/simple.go

"快捷键设置
map <F8>  :set list!<CR>
map <F9>  :bp<CR>
map <F10> :bn<CR>

"勘误
command W w
command Q q

"tern
au BufNewFile,BufRead .tern-project setf json
au BufNewFile,BufRead .tern-config setf json

"build设置
"python
au Filetype python map <buffer> <F5> :!time /usr/bin/env python % <CR>
"php
au Filetype php map <buffer> <F5> :!time /usr/bin/env php % <CR>
"go
au Filetype go map <buffer> <F5> :!time go run % <CR>
"bash
au Filetype sh map <buffer> <F5> :!bash % <CR>

command JsonFormat execute "%!python -m json.tool"
" 解决有时候打开文件需要按 enter 的问题 http://vimhelp.appspot.com/options.txt.html#%27shortmess%27
set shortmess=Ot
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
