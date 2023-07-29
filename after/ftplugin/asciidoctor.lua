vim.bo.textwidth = 80
vim.wo.conceallevel = 3
vim.wo.spell = true


local function goto_link()
  vim.cmd('update')
  local s = vim.api.nvim_get_current_line()
  local _,j1 = string.find(s, "link:")
  local _,j2 = string.find(s, "xref:")
  local j = j1 or j2
  if j then
    local i,_ = string.find(string.sub(s, j+1, -1), "http")
    -- g0  - go to first column
    -- l   - move right by 'j' columns
    -- vt[ - visual select to the next [ char
    -- gf  - go to file under cursor
    -- gx  - go to URL under cursor
    if i == 1 then -- ...this is a hyperlink
      vim.api.nvim_command("normal g0" .. j .. "lgx")
    else
      vim.api.nvim_command("normal g0" .. j .. "lvt[gf")
      -- Below I try to handle the case of a new file, but we have
      -- to be smarter here and tell vim to open the full path to
      -- the file, else it won't know where exactly to create the
      -- file with the relative pathname
      --vim.api.nvim_command("normal g0" .. j .. "l")
      --vim.api.nvim_command(":e <cfile>")
    end
  end
end


local function find_str(s, pat)
  local i, j = string.find(s, pat)
  if j then
    return string.sub(s, i, j)
  else
    return nil
  end
end


local function insert_bullet()

  local s = vim.api.nvim_get_current_line()
  local prefix = find_str(s, "^%*+ %b[] ") or find_str(s, "^%*+ ")
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1]
  local col = pos[2]

  local normal_mode = (vim.api.nvim_get_mode().mode == 'n')

  local this_line
  local next_line

  if normal_mode then
    this_line = s
    next_line = ''
  else
    this_line = string.sub(s, 1, col)
    next_line = string.sub(s, col + 1)
  end

  local indent = 0
  if prefix then
    indent = string.len(prefix)
  end

  if prefix and s == prefix then
     this_line = ''
     indent = 0
  elseif prefix then
     next_line = prefix .. next_line
  end

  vim.api.nvim_buf_set_lines(0, line - 1, line, false, { this_line, next_line })
  vim.api.nvim_win_set_cursor(0, { line + 1, indent })

  if normal_mode then
    vim.cmd('startinsert!')
  end

end


local function indent_bullet()
  local s = vim.api.nvim_get_current_line()
  if string.find(s, "^%*") then
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_text(0, line, 0, line, 0, {"*"})
  end
end


local function undent_bullet()
  local s = vim.api.nvim_get_current_line()
  if string.find(s, "^%*") then
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_text(0, line, 0, line, 1, {""})
  end
end


vim.keymap.set('n', '<cr>', goto_link, { buffer = true })
vim.keymap.set('i', '<cr>', insert_bullet, { buffer = true })
vim.keymap.set('n', 'o', insert_bullet, { buffer = true })
vim.keymap.set('i', '<c-d>', undent_bullet, { buffer = true })
vim.keymap.set('i', '<c-t>', indent_bullet, { buffer = true })

vim.keymap.set('n', '<localleader>d', function () require('notes').delete_note() end, { buffer = true })
vim.keymap.set('n', '<localleader>v', function () vim.fn.system({ 'open', vim.fn.expand('%') }) end, { buffer = true })
