-- Install tsserver:
--
-- npm install -g typescript typescript-language-server
--
-- Then create `tsconfig.json` in your project root.
--
-- Here's an example.  You might consider "es6" instead of "commonjs" for "module".
--
-- {
--   "compilerOptions": {
--     "module": "commonjs",
--     "target": "es6",
--     "checkJs": false
--   },
--   "exclude": [
--     "node_modules"
--   ]
-- }
--
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
--
require('lspconfig').tsserver.setup({
  cmd = { 'typescript-language-server', '--stdio' }})
