" Required options
set nocompatible
set shell=fish
set tw=0
filetype off
set clipboard=unnamedplus
set backspace=indent,eol,start
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=
set clipboard+=unnamedplus
set termguicolors

" Plug
call plug#begin()
Plug 'vim-scripts/indentpython.vim'
Plug 'junegunn/goyo.vim'
Plug 'python-mode/python-mode'
Plug 'mattn/emmet-vim'
Plug 'justinmk/vim-sneak'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'mcchrish/nnn.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-startify'
call plug#end()
filetype plugin indent on
let python_highlight_all=1



" Mappings
nmap ;g :Goyo<CR>
map q <Nop>
map Q <Nop>
map ,c :lcl<CR> :pc<CR> :cclose<CR>
map np :Np<CR>

" Python
let g:pymode_python = 'python3'
:let mapleader = ","
let g:pymode_rope = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_complete_on_dot = 1


" Misc settings
let g:goyo_width = "80%"
let g:goyo_height = "80%"
set background=dark
colorscheme catppuccin-macchiato
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-eslint', 'coc-tsserver', 'coc-python', 'coc-tabnine', 'coc-html', 'coc-snippets', 'coc-rls', 'coc-discord-neovim']

set nu
set relativenumber
syntax on
set laststatus=2
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
au BufNewFile,BufRead *.md
    \ Goyo |
    \ hi StatusLineNC ctermfg=white | 
    \ set nonu | 
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
set encoding=utf-8
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
hi StatusLine ctermbg=none cterm=bold

" Custom commands
command! Compile !pdflatex %:p|!biber file|!pdflatex %:p

" NerdTree
map ,N :NERDTreeToggle<CR>
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")
let NERDTreeShowBookmarks=1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Gutter
set signcolumn=yes

nmap ]h <Plug>(GitGutterNextHunk) "same as default
nmap [h <Plug>(GitGutterPrevHunk) "same as default

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'

" airline
let g:airline_powerline_fonts = 1

" startify
" 'Most Recent Files' number
let g:startify_files_number           = 18

" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

" Simplify the startify list to just recent files and sessions
let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ ]

" Fancy custom header
let g:startify_custom_header = [
  \ "  ",
  \ '   ╻ ╻   ╻   ┏┳┓',
  \ '   ┃┏┛   ┃   ┃┃┃',
  \ '   ┗┛    ╹   ╹ ╹',
  \ '   ',
  \ ]
