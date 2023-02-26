-- This `capabilities` stuff is from the nvim-cmp config, see above
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').clojure_lsp.setup {
  capabilities = capabilities
}
