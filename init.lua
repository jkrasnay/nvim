vim.o.background = 'dark'
vim.opt.completeopt:append({ 'menuone' }) -- Show complete menu even with just one item
vim.o.ignorecase = true                   -- ...when searching
vim.o.incsearch = true                    -- Find matches while typing
vim.o.laststatus = 2                      -- Always show the status line
vim.o.lazyredraw = true                   -- Improves Clojure editing format
vim.o.scrolloff = 2                       -- Min lines to show around cursor while searching
vim.o.smartcase = true                    -- Ignore ignorecase if pattern has uppercase letters
vim.o.splitright = true                   -- Open vertical splits on the right
vim.o.termguicolors = true                -- Enables 24-bit RGB color in the TUI
vim.o.virtualedit = 'block'               -- Allows block selection to go outside current text, handy for vim-drawbox box drawing
vim.o.wildmode = 'longest,list'           -- Wildcard completion

vim.bo.expandtab = true                   -- Expand tabs to spaces
vim.bo.shiftwidth = 4                     -- Amount by which to indent
vim.bo.softtabstop = -1                   -- -1 = use shiftwidth
vim.bo.spelllang = 'en_ca'                -- I am Canadian!

vim.wo.cursorline = true                  -- Highlight the current line
vim.wo.number = true                      -- Show line numbers
vim.wo.wrap = false                       -- Disable virtual line wrapping

vim.api.nvim_create_augroup('Local', {})

vim.api.nvim_create_autocmd('BufEnter', {
        desc = 'Show filename in window title',
        group = 'Local',
        pattern = '*',
        command = [[ let &titlestring = expand("%:t") | set title ]]
})

vim.api.nvim_create_autocmd('BufWritePre', {
        desc = 'Trim trailing whitespace on save',
        group = 'Local',
        pattern = '*',
        command = ':%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd('TermOpen', {
        desc = "Don't kill terminals when buffer hidden",
        group = 'Local',
        pattern = '*',
        command ='setlocal bufhidden=hide nonumber',
})

vim.cmd([[
  filetype plugin indent on
  syntax on
]])

require('plugins')
require('plugin-config/asciidoctor')
require('plugin-config/conjure')
require('plugin-config/gruvbox')
require('plugin-config/leap')
require('plugin-config/lualine')
require('plugin-config/luasnip')
require('plugin-config/nerdtree')
require('plugin-config/nvim-cmp')
require('plugin-config/oil')
require('plugin-config/rainbow')
require('plugin-config/telescope')

require('lsp-config/clojure-lsp')
require('lsp-config/lua-ls')
require('lsp-config/tsserver')

require('keymaps')

vim.cmd([[
silent! runtime site.vim
silent! source .project.vim
]])
