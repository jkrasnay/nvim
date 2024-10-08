-- Customized version of Kickstarter
-- https://github.com/nvim-lua/kickstart.nvim
--
-- TODO
-- * Configure LuaSnip
-- * Move LuaSnip out from under cmp?
-- * Maybe prioritize rainbow parens higher than the colorscheme


-- Globals ------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.have_nerd_font = true


-- Options ------------------------------------------------------------

vim.opt.background = 'dark'
vim.opt.breakindent = true                -- When breaking lines, preserve indent from previous line
vim.opt.completeopt:append({ 'menuone' }) -- Show complete menu even with just one item
vim.opt.cursorline = true                 -- Show which line your cursor is on
vim.opt.hlsearch = false                  -- Don't highlight searched term by default
vim.opt.ignorecase = true                 -- ...when searching
vim.opt.inccommand = 'split'              -- Preview substitutions live, as you type!
vim.opt.incsearch = true                  -- Find matches while typing
vim.opt.list = true
vim.opt.listchars = 'tab:▸ ,trail:·'      -- Show some whitespace
vim.opt.laststatus = 2                    -- Always show the status line
vim.opt.lazyredraw = true                 -- Improves Clojure editing format
vim.opt.number = true                     -- Show line numbers
vim.opt.scrolloff = 2                     -- Min lines to show around cursor while searching
vim.opt.showmode = false                  -- Don't show the mode, since it's already in the status line
vim.opt.smartcase = true                  -- Ignore ignorecase if pattern has uppercase letters
vim.opt.splitright = true                 -- Open vertical splits on the right
vim.opt.termguicolors = true              -- Enables 24-bit RGB color in the TUI
vim.opt.timeoutlen = 300                  -- Displays which-key popup sooner
vim.opt.undofile = true                   -- Save undo history
vim.opt.updatetime = 250                  -- Decrease update time
vim.opt.virtualedit = 'block'             -- Allows block selection to go outside current text, handy for vim-drawbox box drawing
vim.opt.wildmode = 'longest,list'         -- Wildcard completion


-- Keymaps ------------------------------------------------------------

vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })

vim.keymap.set({'n','v'}, ';', ':', { noremap = true })
vim.keymap.set({'n','v'}, ':', ';', { noremap = true })

-- Toggle hlsearch with \ (opposite of /)
vim.keymap.set('n', '\\', '<cmd>set hlsearch!<cr>', { silent = true})

-- Diagnostic keymaps
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Escape insert mode in the terminal
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', {})

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Format tables using pipe separators
vim.keymap.set('v', '|', '<cmd>Tab /|<cr>', { silent = true })


-- Autocommands ------------------------------------------------------------

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Plugin Manager ------------------------------------------------------------

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  { import = 'plugins' },

})


-- My Plugins* ------------------------------------------------------------
--
-- (* Not real plugins, just some Lua modules to do some handy things)
--

local hostname = string.gsub(vim.fn.hostname(), '.local', '')
pcall(require, 'hosts/' .. hostname)

require('projects')
require('keymaps')


-- vim: ts=2 sts=2 sw=2 et
