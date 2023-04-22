-- See https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
--
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- Plugins To Try
--
-- https://github.com/sindrets/diffview.nvim
-- https://github.com/ray-x/lsp_signature.nvim
-- LSP Outliners
--   https://github.com/simrat39/symbols-outline.nvim
--   https://github.com/stevearc/aerial.nvim
--   https://github.com/liuchengxu/vista.vim
--

Plug '~/ws/luhmann.nvim'

--------------------------------------------------------------
-- Appearance
--

-- My favourite theme
Plug 'morhetz/gruvbox'

-- Show matching parens in different colors
Plug 'luochen1990/rainbow'

-- Fancy status line
Plug 'nvim-lualine/lualine.nvim'

-- If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'


--------------------------------------------------------------
-- Navigation
--

-- File browser
Plug 'scrooloose/nerdtree'

-- Super fuzzy search in native Lua
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- Requires silver searcher to be installed
-- https://github.com/ggreer/the_silver_searcher
Plug 'rking/ag.vim'

-- Alternate between source and test files
Plug 'tpope/vim-projectionist'


--------------------------------------------------------------
-- LSP
--

Plug 'neovim/nvim-lspconfig'


--------------------------------------------------------------
-- Autocomplete
--

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'


--------------------------------------------------------------
-- Languages
--

-- Syntax support for many languages
Plug 'sheerun/vim-polyglot'

-- Clojure REPL support
Plug 'Olical/conjure'

-- Support for s-expressions
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

-- Write plugins in Fennel
Plug('Olical/aniseed', { tag = 'v3.8.0' })

-- Fennel, a Clojure-like LISP that compiles to Lua
Plug 'bakpakin/fennel.vim'

-- Asciidoc
Plug 'habamax/vim-asciidoctor'


--------------------------------------------------------------
-- Productivity
--

-- Show calendars, integrates with vimwiki
Plug 'mattn/calendar-vim'

-- Vim Wiki
--
-- <leader>ww to open the wiki
Plug 'vimwiki/vimwiki'


--------------------------------------------------------------
-- PlantUML
--

-- PlugUML Syntax
Plug 'aklt/plantuml-syntax'

-- Required by plantuml-previewer.vim
Plug 'tyru/open-browser.vim'

-- Live preview of PlantUML
Plug 'weirongxu/plantuml-previewer.vim'


--------------------------------------------------------------
-- Utilities
--

-- Alignment plugin
Plug 'godlygeek/tabular'

-- GIT interface
Plug 'tpope/vim-fugitive'

-- Git Gutter
Plug 'airblade/vim-gitgutter'

-- Repeatability
Plug 'tpope/vim-repeat'

-- Snippets editor
--
-- Snippets are in files under ~/.config/nvim/UltiSnips, which is managed by my
-- dotfiles project. They are immediately loaded upon save.
--
Plug 'SirVer/ultisnips'

-- Delete buffers without closing the window
-- Provides :Bdelete and :Bwipeout commands
Plug 'famiu/bufdelete.nvim'

-- Fancy input/select replacement
Plug 'stevearc/dressing.nvim'

vim.call('plug#end')

