-- fix lagginess with deoplete completions
-- Not sure this is needed now that we're on nvim-cmp
vim.g['conjure#client#clojure#nrepl#completion#with_context'] = false

-- don't map K, since we use LSP instead
vim.g['conjure#mapping#doc_word'] = false
