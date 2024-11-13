vim.keymap.set('n', '==', function() vim.cmd('LedgerAlign') end, { buffer = true })

vim.api.nvim_create_autocmd("BufWrite", {
  buffer = 0,
  command = 'LedgerAlignBuffer',
})
