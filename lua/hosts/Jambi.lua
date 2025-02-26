require('erbium')

vim.o.guifont = 'FiraCode Nerd Font:h16'
vim.g.neovide_cursor_vfx_mode = 'railgun'

vim.g.projects = {
  '~/dotfiles',
  '~/ws/erbium',
  '~/ws/erbium-config',
  '~/ws/erbium-db',
  '~/ws/erbium-docs',
  '~/ws/sundog-tools',
  '~/ws/zmk-sweep',
  '~/ws/zoomable-ui',
  '~/Dropbox/erbium-sql',
  '~/Dropbox/sundog-consulting',
}

vim.g.notes_dir = '~/Dropbox/Notes'

vim.g.jdtls_path = '/usr/local/opt/jdtls-1.29.0'
vim.g.jdtls_java_path = '/Users/john/.sdkman/candidates/java/current/bin/java'
vim.g.jdtls_workspaces_dir = '/Users/john/.local/state/jdtls'

-- vim:set ft=lua:
