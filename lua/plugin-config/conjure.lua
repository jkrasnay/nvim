-- fix lagginess with deoplete completions
-- Not sure this is needed now that we're on nvim-cmp
vim.g['conjure#client#clojure#nrepl#completion#with_context'] = false

-- don't map K, since we use LSP instead
vim.g['conjure#mapping#doc_word'] = false

-- Disable LSP diagnostics in the Conjure log buffer
--
-- (vim.diagnostic.disable takes an optional argument which is the number of
-- the buffer to disable diagnostics in. 0 means the current buffer.)
--  autocmd BufEnter conjure-log-* lua vim.diagnostic.disable(0)
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  { pattern = "conjure-log-*", command = "lua vim.diagnostic.disable(0)" })
