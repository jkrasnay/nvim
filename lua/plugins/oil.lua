return {
  'stevearc/oil.nvim',
  opts = {},
  keys = {
    { '<leader>oo', function() require('oil').open() end, desc = '[O]pen this file\'s dir' },
    { '<leader>op', function() require('oil').open(vim.fn.getcwd(-1,0)) end, desc = '[O]pen [P]arent dir' },
  },
}
