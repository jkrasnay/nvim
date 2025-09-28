-- Shows notifications and LSP activity in the bottom right of the page
return {
  'j-hui/fidget.nvim',
  opts = {
    notification = {
      override_vim_notify = true,
    },
  },
}
