return {
  'stevearc/oil.nvim',
  opts = {},
  keys = {
    { '<leader>oo', function() require('oil').open() end, desc = '[O]pen current dir' },
    { '<leader>op', function() require('oil').open(vim.fn.getcwd(-1,0)) end, desc = '[O]pen [P]arent dir' },
    { '<leader>os', function() vim.cmd.split(); require('oil').open() end, desc = '[O]pen current dir in split' },
  },
}
