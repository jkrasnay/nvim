return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd([[colorscheme gruvbox]])
    vim.cmd('hi Keyword guifg=GruvboxAqua')
  end,
}
