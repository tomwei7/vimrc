let g:tvim_mode='tiny'

function tvim#init()
    if !empty(glob('~/.vim/config.vim'))
        source ~/.vim/config.vim
    endif
endfunction
