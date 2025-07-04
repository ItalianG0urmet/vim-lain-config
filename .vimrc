" ___     _______ ___ ______
" |   |   |   _   |   |   _  \
" |.  |   |.  1   |.  |.  |   |
" |.  |___|.  _   |.  |.  |   |
" |:  1   |:  |   |:  |:  |   |
" |::.. . |::.|:. |::.|::.|   |
" `-------`--- ---`---`--- ---'
"

" ----------------------------------------
" Plugins
" ----------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/vim-clang-format'
call plug#end()

" ----------------------------------------
" Core Settings
" ----------------------------------------
set nobackup
set nowritebackup
set noswapfile

syntax enable
set background=dark
if has("termguicolors")
    set termguicolors
endif

" ----------------------------------------
" Colors of the gui
" ----------------------------------------
highlight Normal       guifg=#e0e0e0 guibg=#000000 ctermfg=253 ctermbg=0
highlight Comment      guifg=#5fffaf gui=italic      ctermfg=85
highlight Constant     guifg=#ff87ff                 ctermfg=213
highlight String       guifg=#ffff87                 ctermfg=228
highlight Identifier   guifg=#ff875f                 ctermfg=209
highlight Function     guifg=#ffaf5f gui=bold        ctermfg=215
highlight Type         guifg=#5fafff                 ctermfg=75
highlight Statement    guifg=#5fffff gui=bold        ctermfg=87
highlight PreProc      guifg=#af87ff                 ctermfg=141
highlight Special      guifg=#ff5f5f                 ctermfg=203
highlight LineNr       guifg=#5a5a5a guibg=#101010 ctermfg=240 ctermbg=233
highlight CursorLineNr guifg=#ffffff guibg=#202020 gui=bold ctermfg=15 ctermbg=234
highlight MatchParen   guifg=#ffffff guibg=#3a3a3a ctermfg=15 ctermbg=237
highlight Visual       guibg=#404040                 ctermbg=238
highlight Search       guibg=#5f5f00                 ctermbg=58
highlight IncSearch    guibg=#ffff00 guifg=#000000 ctermbg=11 ctermfg=0
highlight ErrorMsg     guifg=#ff0000 guibg=#2a0000   ctermfg=9
highlight Todo         guifg=#000000 guibg=#ffff00   ctermfg=0 ctermbg=11

" ----------------------------------------
" Menu settings
" ----------------------------------------
set number
set relativenumber

set showcmd
set showmatch
set wildmenu
set title
set ruler

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set ignorecase
set smartcase
set incsearch
set hlsearch

set scrolloff=5
set mouse=a
set clipboard=unnamedplus
set backspace=indent,eol,start

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set list
set listchars=tab:▸\ ,trail:·,nbsp:␣

" ----------------------------------------
" Lightweight Status Line
" ----------------------------------------
set laststatus=2
highlight! StatusLine      guibg=#000000 guifg=#c0c0c0 ctermbg=0 ctermfg=7
highlight! StatusLineNC    guibg=#000000 guifg=#606060 ctermbg=0 ctermfg=8
highlight! StatusLineFile  guibg=#000000 guifg=#ffffff ctermbg=0 ctermfg=15
highlight! StatusLineMod   guibg=#000000 guifg=#ff5f5f ctermbg=0 ctermfg=203
highlight! StatusLineRO    guibg=#000000 guifg=#ff0000 ctermbg=0 ctermfg=9
highlight! StatusLineType  guibg=#000000 guifg=#5fff87 ctermbg=0 ctermfg=84
highlight! StatusLinePos   guibg=#000000 guifg=#ffff5f ctermbg=0 ctermfg=227
highlight! StatusLinePct   guibg=#000000 guifg=#af87ff ctermbg=0 ctermfg=141
highlight! StatusLineFill guibg=#000000 ctermbg=0

set fillchars+=stl:\ ,stlnc:\
function! GetStatusLine()
    let status = ""
    let status .= "%#StatusLineFile# %<%f"
    let status .= "%#StatusLineMod#%m"
    let status .= "%#StatusLineRO#%r%h%w"
    let status .= "%#StatusLineFill#%="
    let status .= "%#StatusLineType# %y "
    let status .= "%#StatusLinePos# %3l:%-2c "
    let status .= "%#StatusLinePct# %3p%% "

    return status
endfunction

set statusline=%!GetStatusLine()

augroup StatusLineBlack
    autocmd!
    autocmd ColorScheme * highlight StatusLineFill guibg=#000000 ctermbg=0
    autocmd VimEnter,WinEnter * setlocal statusline=%!GetStatusLine()
augroup END

" ----------------------------------------
" Performance Tweaks
" ----------------------------------------
set lazyredraw
set ttyfast
set timeoutlen=500
set ttimeoutlen=50
set updatetime=300


let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

" ----------------------------------------
" For Language config
" ----------------------------------------
augroup filetype_specific
    autocmd!
    " Python
    autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
    autocmd FileType python nnoremap <buffer> <Leader>r :exec '!python' shellescape(@%, 1)<CR>

    " Markdown
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal linebreak

    " JavaScript/TypeScript
    autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2 expandtab
augroup END

" ----------------------------------------
" Shortcut
" ----------------------------------------
let mapleader = " "
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>t :term<CR>
nnoremap <leader>l :Lint<CR>
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <leader>f :ClangFormat<CR>
nnoremap <leader>h :call OpenCorrespondingHeader()<CR>

" ----------------------------------------
" Search and open the .h of current file
" ----------------------------------------
function! OpenCorrespondingHeader()

  if &filetype != 'c' && &filetype != 'cpp'
    echo "Not a C/C++ file, skipping header search"
    return
  endif

  let current_file = expand('%:p')
  let base_name = expand('%:t:r')

  let candidates = [
        \ expand('%:p:h') . '/' . base_name . '.h',
        \ expand('%:p:h') . '/../include/' . base_name . '.h',
        \ expand('%:p:h') . '/../inc/' . base_name . '.h',
        \ expand('%:p:h') . '/../../include/' . base_name . '.h',
        \ getcwd() . '/include/' . base_name . '.h'
        \ ]

  for candidate in candidates
    if filereadable(candidate)
      execute 'edit ' . fnameescape(candidate)
      return
    endif
  endfor

  let new_header = getcwd() . '/include/' . base_name . '.h'
  if confirm("Create " . new_header . "?", "&Yes\n&No", 2) == 1
    execute 'edit ' . fnameescape(new_header)
  endif
endfunction

" ----------------------------------------
" Lint visual
" ----------------------------------------
command! Lint call s:LintCurrentFile()
function! s:LintCurrentFile()

  if &filetype != 'c' && &filetype != 'cpp'
    echo "Not a C/C++ file, skipping lint"
    return
  endif

  if &modified
    silent write
  endif
  let l:file_path = expand('%:p')
  if filereadable(l:file_path)
    set errorformat=%f:%l:%c:\ %m
    execute 'cexpr system("cppcheck --enable=all --suppress=missingIncludeSystem --quiet ' . shellescape(l:file_path) . ' 2>&1")'
    cwindow
  else
    echo "File not saved! Use :w first."
  endif
endfunction
