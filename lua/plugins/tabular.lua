return {
  'godlygeek/tabular',
  config = function()
    -- Format tables using pipe separators
    vim.keymap.set('v', '|', '<cmd>Tab /|<cr>', { silent = true })
  end
}
