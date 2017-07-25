set nocompatible              " be iMproved, required
set shortmess=atI
set backspace=indent,eol,start
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Airline: 状态栏
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'altercation/vim-colors-solarized'
" NERDtree: 文件浏览器
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'godlygeek/tabular'
"Plug 'terryma/vim-multiple-cursors'

Plug 'Valloric/YouCompleteMe'
Plug 'mattn/emmet-vim', {'for': ['html', 'css']}
"Plug 'w0rp/ale'
Plug 'vim-syntastic/syntastic'
Plug 'DoxygenToolkit.vim', {'for': ['c', 'cpp']}
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}

"golang
Plug 'buoto/gotests-vim', {'for': 'go'}   "自动生成单元测试
Plug 'fatih/vim-go', {'for': 'go'}

"javascript
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'posva/vim-vue', {'for': 'vue'}
" Initialize Plug system
call plug#end()

"Plugin Config start
"YouCompleteMe Config
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'
let g:ycm_key_invoke_completion = '<C-a>'

nmap gd :YcmCompleter GoToDefinition <CR>

"离开插入模式后自动关闭预览窗口
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif	

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
"let py_version=system("python --version")
"if has('python')
"    if matchstr(py_version, 'Python 2') != ''
"        let g:syntastic_python_flake8_exec="/usr/local/bin/python -m flake8"
"    elseif matchstr(py_version, 'Python 3') != ''
"        let g:syntastic_python_flake8_exec="/usr/local/bin/python3 -m flake8"
"    endif
"endif

" 清除macvim滚动条
if has('gui')
    set guioptions-=gmrL
endif

"vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 0

"markdown
let g:vim_markdown_folding_disabled = 1 "设置不做代码折叠

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"主题设置
silent! colorscheme solarized
set background=dark
let g:solarized_termcolors=256

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
"开启高亮
syntax enable
"编码支持
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
"高亮当前行
set cursorline
highlight clear SignColumn
hi CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE
hi Normal ctermbg=NONE
"自动补全括号
"inoremap (  ()<left>
"inoremap [ []<left>
"inoremap " ""<left>
"inoremap ' ''<left>
"设置不可见字符
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" gui
set guifont=Monaco:h13

"不同文件缩进
autocmd Filetype html setlocal ts=2 sts=2 sw=2
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
