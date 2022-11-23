vim.bo.textwidth = 80
vim.wo.conceallevel = 3
vim.wo.spell = true


function asciidoctor_goto_link()
  s = vim.api.nvim_get_current_line()
  _,j1 = string.find(s, "link:")
  _,j2 = string.find(s, "xref:")
  j = j1 or j2
  if j then
    i,_ = string.find(string.sub(s, j+1, -1), "http")
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


function find_str(s, pat)
  i, j = string.find(s, pat)
  if j then
    return string.sub(s, i, j)
  else
    return nil
  end
end


function asciidoctor_insert_bullet()
  s = vim.api.nvim_get_current_line()
  prefix = find_str(s, "^%*+ %b[] ") or find_str(s, "^%*+ ")
  pos = vim.api.nvim_win_get_cursor(0)
  line = pos[1]
  col = pos[2]
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
    -- not in a list, just add a new blank line
    vim.api.nvim_buf_set_lines(0, line, line, false, {''})
    vim.api.nvim_win_set_cursor(0, { line + 1, 0 })
  end
  -- in case we invoked from normal mode, e.g. with 'o'
  vim.cmd('startinsert!')
end


function asciidoctor_indent_bullet()
  s = vim.api.nvim_get_current_line()
  if string.find(s, "^%*") then
    line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_text(0, line, 0, line, 0, {"*"})
  end
end


function asciidoctor_undent_bullet()
  s = vim.api.nvim_get_current_line()
  if string.find(s, "^%*") then
    line = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_text(0, line, 0, line, 1, {""})
  end
end


vim.keymap.set('n', '<cr>', ':w<cr>:lua asciidoctor_goto_link()<cr>', { buffer = true })
vim.keymap.set('i', '<cr>', asciidoctor_insert_bullet, { buffer = true })
vim.keymap.set('n', 'o', asciidoctor_insert_bullet, { buffer = true })
vim.keymap.set('i', '<c-d>', asciidoctor_undent_bullet, { buffer = true })
vim.keymap.set('i', '<c-t>', asciidoctor_indent_bullet, { buffer = true })
