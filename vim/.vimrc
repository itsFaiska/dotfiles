"=============================================================
" ~/.vimrc
" Vim Configuration
" ============================================================

" ------------------------------------------------------------
" Core
" ------------------------------------------------------------

set nocompatible
set encoding=utf-8
set hidden

filetype plugin indent on
syntax enable

" ------------------------------------------------------------
" Leader
" ------------------------------------------------------------

let mapleader = " "
let maplocalleader = " "

" ------------------------------------------------------------
" Interface
" ------------------------------------------------------------

set number

set cursorline
set signcolumn=yes

set ruler
set showcmd
set showmode

set scrolloff=8
set sidescrolloff=8

set laststatus=2
set cmdheight=1

set wildmenu
set wildmode=longest:full,full

" Mantém as cores padrão do Vim
set background=dark

" ------------------------------------------------------------
" Editor
" ------------------------------------------------------------

set autoindent
set smartindent

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set textwidth=0
set wrap
set linebreak

set backspace=indent,eol,start

" ------------------------------------------------------------
" Busca
" ------------------------------------------------------------

set ignorecase
set smartcase
set incsearch
set hlsearch

" Esc limpa o highlight da busca
nnoremap <Esc> :nohlsearch<CR>

" ------------------------------------------------------------
" Clipboard
" ------------------------------------------------------------

set clipboard=unnamedplus

" ------------------------------------------------------------
" Arquivos
" ------------------------------------------------------------

set autoread

set nobackup
set nowritebackup
set noswapfile

" Undo persistente
set undofile
set undodir=~/.vim/undo

" ------------------------------------------------------------
" Splits
" ------------------------------------------------------------

set splitbelow
set splitright

" Navegar entre splits com Ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ------------------------------------------------------------
" Redimensionar Splits
" ------------------------------------------------------------

nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" ------------------------------------------------------------
" Navegação
" ------------------------------------------------------------

" Centralizar tela ao navegar
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzzzv
nnoremap N Nzzzv

" ------------------------------------------------------------
" Salvamento
" ------------------------------------------------------------

nnoremap <C-s> :write<CR>
inoremap <C-s> <Esc>:write<CR>a

" ------------------------------------------------------------
" Sair
" ------------------------------------------------------------

nnoremap <C-q> :quit<CR>

" Salvar e sair
nnoremap <C-x> :x<CR>

" ------------------------------------------------------------
" Tabs
" ------------------------------------------------------------

nnoremap <C-t> :tabnew<CR>

nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" ------------------------------------------------------------
" Visual
" ------------------------------------------------------------

set list
set listchars=tab:→\ ,trail:·,extends:>,precedes:<

set fillchars=eob:\ 

" ------------------------------------------------------------
" Performance
" ------------------------------------------------------------

set updatetime=300
set timeoutlen=500

" ------------------------------------------------------------
" Buffers
" ------------------------------------------------------------

" Buffer anterior
nnoremap <S-H> :bprevious<CR>

" Próximo buffer
nnoremap <S-L> :bnext<CR>

" Novo buffer
nnoremap <leader>bn :enew<CR>

" Fechar buffer atual
nnoremap <leader>bd :bdelete<CR>

" Listar buffers
nnoremap <leader>bl :buffers<CR>

" ------------------------------------------------------------
" Statusline
" ------------------------------------------------------------

set statusline=
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=\ %l:%c
set statusline+=\ %p%%

" ------------------------------------------------------------
" Netrw - File Explorer
" ------------------------------------------------------------

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:netrw_keepdir = 0
let g:netrw_preview = 1
let g:netrw_hide = 0

nnoremap <leader>e :Explore<CR>
nnoremap <leader>E :Explore ~<CR>

" ------------------------------------------------------------
" LSP
" ------------------------------------------------------------

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '--background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if executable('pyright-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyright',
        \ 'cmd': {server_info->['pyright-langserver', '--stdio']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \ })
endif

" Mostrar diagnósticos
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

nnoremap <leader>ld :LspDefinition<CR>
nnoremap <leader>lr :LspReferences<CR>
nnoremap <leader>li :LspImplementation<CR>
nnoremap <leader>lh :LspHover<CR>
nnoremap <leader>ln :LspNextDiagnostic<CR>
nnoremap <leader>lp :LspPreviousDiagnostic<CR>
nnoremap <leader>lf :LspDocumentFormat<CR>
