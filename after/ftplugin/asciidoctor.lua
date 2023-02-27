vim.bo.textwidth = 80
vim.wo.conceallevel = 3
vim.wo.spell = true


local function asciidoctor_goto_link()
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


local function asciidoctor_insert_bullet()

  local s = vim.api.nvim_get_current_line()
  local prefix = find_str(s, "^%*+ %b[] ") or find_str(s, "^%*+ ")
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1]
  local col = pos[2]

  if prefix then
    if s == prefix then
      -- line is blank, erase the prefix and enter insert mode
      vim.api.nvim_buf_set_text(0, line - 1, 0, line - 1, string.len(s), {""})
    elseif string.find(s, ":$") then
      -- line ends with a colon, indent the bullet
      vim.api.nvim_buf_set_lines(0, line, line, false, {"*" .. prefix})
      vim.api.nvim_win_set_cursor(0, { line + 1, string.len(prefix) + 1 })
    else
      -- add a line with a new bullet
      vim.api.nvim_buf_set_lines(0, line, line, false, {prefix})
      vim.api.nvim_win_set_cursor(0, { line + 1, string.len(prefix) })
    end
  else
    -- not in a list, just split the current line
    vim.api.nvim_buf_set_lines(0, line - 1, line, false, {string.sub(s, 1, col), string.sub(s, col + 1)})
    vim.api.nvim_win_set_cursor(0, { line + 1, 0 })
  end

  if vim.api.nvim_get_mode().mode == 'n' then
    vim.cmd('startinsert!')
  end

end


local function asciidoctor_indent_bullet()
  local s = vim.api.nvim_get_current_line()
  if string.find(s, "^%*") then
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_text(0, line, 0, line, 0, {"*"})
  end
end


local function asciidoctor_undent_bullet()
  local s = vim.api.nvim_get_current_line()
  if string.find(s, "^%*") then
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_text(0, line, 0, line, 1, {""})
  end
end


vim.keymap.set('n', '<cr>', ':w<cr>:lua asciidoctor_goto_link()<cr>', { buffer = true })
vim.keymap.set('i', '<cr>', asciidoctor_insert_bullet, { buffer = true })
vim.keymap.set('n', 'o', asciidoctor_insert_bullet, { buffer = true })
vim.keymap.set('i', '<c-d>', asciidoctor_undent_bullet, { buffer = true })
vim.keymap.set('i', '<c-t>', asciidoctor_indent_bullet, { buffer = true })
