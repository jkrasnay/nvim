-- Key Mappings

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local map = vim.api.nvim_set_keymap

map('i', 'jj', '<Esc>', { noremap = true })

map('n', '<leader>', [[:<c-u>WhichKey '<Space>'<CR>]], { noremap = true })
map('n', '<localleader>', [[:<c-u>WhichKey  ','<CR>]], { noremap = true })

-- System clipboard
map('i', '<c-v>', '<c-r>+', { noremap = true })
--map('v', '<c-c>., '"+y', { noremap = true })

map('c', '<c-a>', '<home>', { noremap = true })
map('c', '<c-e>', '<end>', { noremap = true })

-- Map completion to Ctrl-Space
map('i', '<C-Space>', 'compe#complete()', { expr = true })

-- Clear highlight with \ (opposite of /)
map('n', '\\', ':noh<cr>', { silent = true})

-- Mappings to quickly move through the results
--
-- Move quickly between windows
map('n', '<C-h>', '<c-w>h', { silent = true })
map('n', '<C-j>', '<c-w>j', { silent = true })
map('n', '<C-k>', '<c-w>k', { silent = true })
map('n', '<C-l>', '<c-w>l', { silent = true })

-- Use shift + hjkl to resize windows
map('n', '<s-down>',  ':resize -2<CR>', { silent = true })
map('n', '<s-up>',    ':resize +2<CR>', { silent = true })
map('n', '<s-left>',  ':vertical resize -2<CR>', { silent = true })
map('n', '<s-right>', ':vertical resize +2<CR>', { silent = true })

-- Escape insert mode in the terminal
map('t', '<esc>', '<c-\\><c-n>', {})

-- Format tables using pipe separators
map('v', '|', ':Tab /|<cr>', { silent = true })

-- Show the given buffer along the top of the tab
vim.cmd(':command! -nargs=? Top :top :new | :b <args>')

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
-- Spacemacs/Spacevim inspired mappings
--
-- Let this be the way forward!
--============================================================

--------------------------------------------------------------
-- Quickfix commands SPC c...
--------------------------------------------------------------
--
map('n', '<leader>cn', ':cn<cr>', { silent = true })
map('n', '<leader>cp', ':cp<cr>', { silent = true })


--------------------------------------------------------------
-- File commands SPC f...
--------------------------------------------------------------

map('n', '<leader>ft', ':NERDTreeToggle<cr>',           { silent = true })
map('n', '<leader>ff', ':NERDTreeFind<cr>',             { silent = true })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>',  {})
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>',    {})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>',  {})
map('n', '<leader>fz', '<cmd>Telescope find_files<cr>', {})

--------------------------------------------------------------
-- Notes commands SPC n...
--------------------------------------------------------------

map('n', '<leader>nd', ':Diary<cr>',   { silent = true })
map('n', '<leader>ni', ':NewNote<cr>', { silent = true })
map('n', '<leader>nn', ':Notes<cr>',   { silent = true })
