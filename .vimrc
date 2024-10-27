
nnoremap <F6> :w<CR>:!make<CR>

" Enable file type detection, plugins, and indentationDone!Done!
filetype on
filetype plugin on
filetype indent on

" Enable syntax highlighting and default color scheme
syntax on

" Enable line numbering
set number

" C-style indentation settings
set cindent
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set foldmethod=syntax
set foldlevelstart=0

" Enable ruler to show cursor position
set ruler

" Backspace key behavior
set backspace=indent,eol,start

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Add numbers to each line on the left-hand side.
set number

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'      " Asynchronous Lint Engine
Plug 'preservim/nerdtree'      " NERDTree File Explorer
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-fugitive'      " Git pluggin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cdelledonne/vim-cmake'
Plug 'raimondi/delimitmate'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'neoclide/coc-snippets'
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/coc-yaml'
Plug 'avakhov/vim-yaml'
Plug 'skanehira/docker-compose.vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'kkvh/vim-docker-tools'
Plug 'skanehira/denops-docker.vim'
Plug 'jamestthompson3/nvim-remote-containers'
Plug 'othree/html5.vim'
Plug 'cjrh/vim-conda'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'ironcamel/vim-script-runner'
Plug 'auxiliary/vim-layout'
Plug 'junegunn/fzf'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer')}

call plug#end()

" Set colorscheme after moonfly plugin has loaded

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

inoremap jj <esc>
" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <F4> :w <CR>:!clear <CR>:!python3 % <CR>

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTree<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

"autocmd FileType html setlocal foldmethod=indent
"autocmd FileType javascript setlocal foldmethod=indent
"autocmd FileType c setlocal foldmethod=syntax
"set foldlevelstart=0

" If GUI version of Vim is running set these options.
if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme moonfly

    " Set a custom font you have installed on your computer.
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size>
    set guifont=Monospace\ Regular\ 12

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the right-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the <F2> key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
    nnoremap <F2> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>

endif

let g:ranger_replace_netrw = 1

function! s:customize_dracula() abort
      " Adjust the Normal background to a darker color
      highlight Normal guibg=#1c1f26 ctermbg=234

      " Customize the CursorLine to make it darker but still visible
      highlight CursorLine guibg=#2a2e36 ctermbg=235

      " Adjust other elements for a darker tone if desired
      " highlight StatusLine guibg=#2a2e36 cterm=bold
      " highlight LineNr guifg=#5a5f73 guibg=#1c1f26 ctermfg=60 ctermbg=235
      " highlight Comment guifg=#4a4f66 ctermfg=59

      " Customize more groups to darken the overall theme
      " highlight GitGutterAdd guifg=#3d5a40 ctermfg=22
      " highlight GitGutterChange guifg=#4f6fa0 ctermfg=25
      " highlight GitGutterDelete guifg=#6f343f ctermfg=52
endfunction

augroup DraculaCustomization
  autocmd!
  autocmd ColorScheme dracula call s:customize_dracula()
augroup END

colorscheme dracula


" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" }}}
