-- Key Mappings

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local map = vim.keymap.set

map('i', 'jj', '<Esc>', { noremap = true })

map({'n','v'}, ';', ':', { noremap = true })
map({'n','v'}, ':', ';', { noremap = true })

-- System clipboard
map('i', '<c-v>', '<c-r>+', { noremap = true })
--map('v', '<c-c>., '"+y', { noremap = true })

map('c', '<c-a>', '<home>', { noremap = true })
map('c', '<c-e>', '<end>', { noremap = true })

-- Map completion to Ctrl-Space
map('i', '<C-Space>', 'compe#complete()', { expr = true })

-- Clear highlight with \ (opposite of /)
map('n', '\\', '<cmd>noh<cr>', { silent = true})

-- Mappings to quickly move through the results
--
-- Move quickly between windows
map('n', '<C-h>', '<c-w>h', { silent = true })
map('n', '<C-j>', '<c-w>j', { silent = true })
map('n', '<C-k>', '<c-w>k', { silent = true })
map('n', '<C-l>', '<c-w>l', { silent = true })

-- Use shift + hjkl to resize windows
map('n', '<s-down>',  '<cmd>resize -2<CR>', { silent = true })
map('n', '<s-up>',    '<cmd>resize +2<CR>', { silent = true })
map('n', '<s-left>',  '<cmd>vertical resize -2<CR>', { silent = true })
map('n', '<s-right>', '<cmd>vertical resize +2<CR>', { silent = true })

-- Escape insert mode in the terminal
map('t', '<esc>', '<c-\\><c-n>', {})

-- Format tables using pipe separators
map('v', '|', '<cmd>Tab /|<cr>', { silent = true })

-- Show the given buffer along the top of the tab
vim.cmd(':command! -nargs=? Top :top :new | :b <args>')

-- Use Home/End to move between tabs
map('n', '<Home>', vim.cmd.tabprevious, { silent = true })
map('n', '<End>', vim.cmd.tabnext, { silent = true })

--============================================================
-- Neovim Native LSP Client Config
--============================================================

-- These are customized for Clojure
-- :h lsp-config to find other mappings
-- Oh, now they do it in a more Lua-ish way
-- Nvm, works for now!
map('n', 'K',     '<cmd>lua vim.lsp.buf.hover()<CR>', {})
map('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})
map('n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>', {})
map('n', 'gd',    '<cmd>lua vim.lsp.buf.definition()<CR>', {})
map('n', 'gA',    '<cmd>lua vim.lsp.buf.code_action()<CR>', {})
map('n', 'gR',    '<cmd>lua vim.lsp.buf.rename()<CR>', {})
map('n', 'ge',    '<cmd>lua vim.diagnostic.open_float()<CR>', {})
map('n', 'gi',    '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', {})
map('n', 'go',    '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', {})
map('n', 'gn',    '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
map('n', 'gp',    '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})


--============================================================
-- Snippets
--============================================================

local ls = require('luasnip')

vim.keymap.set({ 'i', 's' }, '<Tab>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

--vim.keymap.set('i', '<c-l>', function()
--  if ls.choice_active() then
--    ls.change_choice(1)
--  end
--end, { silent = true })

--============================================================
-- Spacemacs/Spacevim inspired mappings
--
-- Let this be the way forward!
--============================================================

--------------------------------------------------------------
-- Buffer commands SPC b...
--------------------------------------------------------------
--
map('n', '<leader>bd', '<cmd>bp|bd#<cr>', { silent = true }) -- delete buffer w/o closing window

--------------------------------------------------------------
-- Quickfix commands SPC c...
--------------------------------------------------------------
--
map('n', '<leader>cn', '<cmd>up|cn<cr>', { silent = true })
map('n', '<leader>cp', '<cmd>up|cp<cr>', { silent = true })


--------------------------------------------------------------
-- File commands SPC f...
--------------------------------------------------------------

--map('n', '<leader>ft', '<cmd>NERDTreeToggle<cr>',           { silent = true })
--map('n', '<leader>ff', '<cmd>NERDTreeFind<cr>',             { silent = true })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>',  {})
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>',    {})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>',  {})
map('n', '<leader>fz', '<cmd>Telescope find_files<cr>', {})

--------------------------------------------------------------
-- Git commands SPC g...
--------------------------------------------------------------

map('n', '<leader>gg', '<cmd>Git<cr>', { silent = true })
map('n', '<leader>gp', '<cmd>Git push<cr>', { silent = true })

--------------------------------------------------------------
-- Notes commands SPC n...
--------------------------------------------------------------

map('n', '<leader>nd', '<cmd>lua require("notes").new_diary_entry()<cr>', { silent = true })
map('n', '<leader>ni', '<cmd>lua require("notes").new_note()<cr>',        { silent = true })
map('n', '<leader>nn', '<cmd>lua require("notes").edit_index()<cr>',      { silent = true })
--map('n', '<leader>nl', '<cmd>lua require("notes").list_notes()<cr>',      { silent = true })
map('n', '<leader>nl', require("notes").list_notes,      { silent = true })
map('n', '<leader>nx', '<cmd>lua require("notes").index_notes()<cr>',      { silent = true })

--------------------------------------------------------------
-- Oil commands SPC o...
--------------------------------------------------------------

map('n', '<leader>oo', require('oil').open, { silent = true })
map('n', '<leader>oh', function() require('oil').open('~') end, { silent = true })
map('n', '<leader>op', function() require('oil').open(vim.fn.getcwd(-1,0)) end, { silent = true })
map('n', '<leader>ow', function() require('oil').open('~/ws') end, { silent = true })

--------------------------------------------------------------
-- Project commands SPC p...
--------------------------------------------------------------

map('n', '<leader>p', require('projects').select_project, { silent = true })


--------------------------------------------------------------
-- Tool commands SPC t...
--------------------------------------------------------------

map('n', '<leader>t', require('tasks').select_task, { silent = true })
