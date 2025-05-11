set tabstop=2
set shiftwidth=2
set expandtab
set number
set ruler

match ErrorMsg '\s\+$'

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

autocmd FileWritePre * :call TrimWhiteSpace()
autocmd FileAppendPre * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre * :call TrimWhiteSpace()

let mapleader = ","

filetype plugin on
filetype indent on
syntax on
