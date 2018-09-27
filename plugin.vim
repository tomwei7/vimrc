" vim-plug config A minimalist Vim plugin manager.
" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" base plugin
Plug 'bling/vim-airline'
Plug 'ascenator/L9', {'name': 'newL9'}
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'godlygeek/tabular'
Plug 'Yggdroot/LeaderF', {'do': './install.sh', 'on': ['LeaderfFile', 'LeaderfBuffer', 'LeaderfFunction', 'LeaderfBufTag', 'LeaderfBufTagAll']}
Plug 'wincent/ferret', {'on': 'Ack'}
Plug 'skywind3000/asyncrun.vim', {'on': 'AsyncRun'}
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'

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

""" ariline {{{
if has_key(g:plugs, 'vim-airline')
    if has_key(g:plugs, 'gruvbox')
        let g:airline_theme='gruvbox'
    endif
    let g:airline_powerline_fonts=g:tvim_powerline_fonts
    let g:airline_highlighting_cache=1
endif
" }}}

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
