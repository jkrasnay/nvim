vim.keymap.set('n', '==', function() vim.cmd('LedgerAlign') end, { buffer = true })

vim.api.nvim_create_autocmd("Bufrite", {
  buffer = 0,
  command = 'LedgerAlignBuffer',
})
