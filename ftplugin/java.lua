-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- See https://github.com/mfussenegger/dotfiles/vim/.config/nvim/ftplugin/java.lua
--
-- Requires the following global variables to be defined:
--
-- vim.g.jdtls_path           - Path where jdtls itself is installed.
-- vim.g.jdtls_java_path      - Path to the `java` executable.  Must be at least Java 17.
-- vim.g.jdtls_workspaces_dir - Dir where jdtls will store workspace information for each project
--
-- Jdtls can be installed via brew but it seems to come with a bunch of extra
-- crap like openjdk and ghostscript. So I just recommend downloading it from
-- https://download.eclipse.org/jdtls/milestones/ and unpacking it yourself.
--
-- WARNING: contents of the jdtls tarballs do not have a common path You need
-- to create your own directory like `jdtls-1.29.0` and untar into that.
--
-- DEBUGGING
--
-- * Run `:LspLog` and check the logs there
-- * Also find a file called `.log` under the configured jdtls_workspaces_dir
--

if not pcall(require, 'jdtls.setup') then
  print('Plugin mfussenegger/nvim-jdtls not found')
  return
end

for _, v in ipairs({ 'jdtls_path', 'jdtls_java_path', 'jdtls_workspaces_dir' }) do
  if not vim.g[v] then
    print('Missing global setting vim.g.' .. v)
    return
  end
end

local root_markers = { 'pom.xml' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_dir = vim.g.jdtls_workspaces_dir .. '/' .. vim.fn.fnamemodify(root_dir, ":t") -- Note: this must not be a subdir of the project
local launcher_path = vim.fs.find(
  function (name, _)
    return name:match('org.eclipse.equinox.launcher_.*.jar$')
  end,
  { path = vim.g.jdtls_path })[1]

local config_path
if vim.fn.has('win32') > 0 then
  config_path = vim.g.jdtls_path .. '/config_win'
else
  config_path = vim.g.jdtls_path .. '/config_mac'
end

if not root_dir then
  print('Could not find Maven pom.xml')
  return
end

if not launcher_path then
  print('Could not find launcher path. Are you sure vim.g.jdtls_path (' .. vim.g.jdtls_path .. ') is correct?')
  return
end

local config = {
  -- the command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    vim.g.jdtls_java_path,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher_path,
    '-configuration', config_path,
    '-data', workspace_dir,
  },

  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use addtional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  }
}

require('jdtls').start_or_attach(config)
