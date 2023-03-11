vim.bo.shiftwidth = 2

vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>eb', ':up<cr>:luafile %<cr>', { noremap = true })

local function string_starts_with(s, prefix)
  return string.sub(s, 1, string.len(prefix)) == prefix
end

-- Returns the Lua package name of the file in the current buffer
-- or nil if the file is not found on the nvim runtime path for Lua files.
--
local function current_lua_package()
  local curr_file = vim.fn.expand('%:p')
  local rel_path
  local count = 0
  for _, p in ipairs(vim.api.nvim_list_runtime_paths()) do
    count = count + 1
    local plua = p .. '/lua'
    if string_starts_with(curr_file, plua) then
      rel_path = string.sub(curr_file, string.len(plua) + 2, -1)
      break
    end
  end
  if rel_path then
    return string.gsub(string.gsub(rel_path, '[.]lua$', ''), '/', '.')
  end
end


-- Unloads the current Lua package associated with the current buffer.
-- Returns the package name or nil if we could not find the matching
-- package.
--
local function unload_current_lua_package()
  local pkg = current_lua_package()
  if pkg then
    vim.cmd('update')
    package.loaded[pkg] = nil
  end
  return pkg
end


vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>u', '',
  {
    noremap = true,
    callback = function()
      local pkg = unload_current_lua_package()
      if pkg then
        print("Unloaded package " .. pkg)
      else
        print("Current file is not an nvim Lua package")
      end
    end
  })

vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>r', '',
  {
    noremap = true,
    callback = function()
      vim.cmd('update')
      vim.cmd('luafile %')
      print('Reloaded ' .. vim.fn.expand('%'))
    end
  })
