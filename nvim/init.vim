" Basic settings
set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets
set ignorecase              " Case insensitive search
set mouse=v                 " Middle-click paste
set hlsearch                " Highlight search results
set incsearch               " Incremental search
set tabstop=4               " Number of columns a tab counts for
set softtabstop=4           " Spaces to use when pressing <BS>
set expandtab               " Convert tabs to spaces
set shiftwidth=4            " Width for auto indents
set autoindent              " Indent new lines the same as the previous line
set number                  " Show line numbers
set wildmode=longest,list   " Bash-like tab completion
set cc=80                   " Set 80 character column limit
filetype plugin indent on    " Enable file type detection and indentation
syntax on                   " Enable syntax highlighting
set mouse=a                 " Enable mouse in all modes
set clipboard=unnamedplus   " Use system clipboard
set cursorline              " Highlight current line
set ttyfast                 " Speed up scrolling
" set spell                 " Enable spell check
" set noswapfile            " Disable creating swap files
" set backupdir=~/.cache/vim " Directory to store backup files.

" Plugin manager setup
call plug#begin('~/.local/share/nvim/plugged')

" List your plugins here:
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'scottmckendry/cyberdream.nvim'
call plug#end()

" Setup Mason and LSP
lua << EOF
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright" },
    automatic_installation = true,
})

-- Load servers using the new API
local lspconfig = vim.lsp._config  -- transitional alias in 0.11

-- Lua LS (sumneko/lua-language-server)
vim.lsp.start({
  name = "lua_ls",
  cmd = { "lua-language-server" },
  root_dir = vim.fs.dirname(vim.fs.find({".git"}, { upward = true })[1]),
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})
EOF
lua << EOF
require("cyberdream").setup({
    variant="default",
    transparent = true,
    saturation = 1,
    italic_comments = true,
    terminal_colors = true,
    extensions = { telescope = true,},
})
EOF
colorscheme cyberdream
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
