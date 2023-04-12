-- Interaction with files in my Notes directory
--
-- These are all asciidoc files
--

local notes_dir = "~/Dropbox/Notes"

local function note_index(args)
  if type(args) == 'table' then
    args = table.concat(args, ' ')
  end
  return vim.fn.system('note-index --dir ' .. notes_dir .. ' ' .. args)
end

local M = {}

function M.edit_index()
  vim.cmd('e ' .. notes_dir .. '/index.adoc')
  --command! Notes execute "e " . g:notes_dir . "/index.adoc"
end

function M.new_diary_entry()
  vim.fn.mkdir(vim.fn.expand(notes_dir .. vim.fn.strftime("/Diary/%Y/%m")), "p")
  vim.api.nvim_command("e " .. notes_dir .. vim.fn.strftime("/Diary/%Y/%m/%F.adoc"))
  if vim.fn.line("$") == 1 then
    -- TODO add the date to the top of the file
  end
end

function M.new_note()
  vim.fn.mkdir(vim.fn.expand(notes_dir .. vim.fn.strftime("/%Y")), "p")
  vim.api.nvim_command("e " .. notes_dir .. vim.fn.strftime("/%Y/%Y%m%d%H%M%S.adoc"))
  print('new note 2')
end

-- Experimental: generate a read-only buffer
function M.show_note_list()
  vim.cmd([[
  top new
  file notelist
  set bufhidden=delete
  set buftype=nofile
  set filetype=asciidoctor
  set nonumber
  ]])
  --[[
  vim.api.nvim_put({'= Note List'}, 'l', false, true)
  vim.api.nvim_put({'* foo'}, 'l', true, false)
  vim.api.nvim_put({'* bar'}, 'l', true, false)
  vim.api.nvim_put({'* baz'}, 'l', true, false)
  --]]
  --
  local lines = {
    '= Note List',
    '',
    '* foo2',
    '* bar2',
    '* baz2',
  }
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
  -- TODO hrm, I think I like nvim_put better, since it remembers where you're at
  -- so you can just keep calling it
  -- TODO check if buffer exists and re-create if necessary
  --   * see nvim_list_bufs() to get a list of buffers
  --   * also check nvim_buf_is_loaded() to confirm it's still valid
  --   * vim.fn.bufwinnr('notelist') might help here
  --   * gotta detect if the buffer is visible (currently attached to a window)
end


-- Executes the given command and returns the stdout
--
local function exec(cmd)
  local handle = assert(io.popen(cmd))
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()
    return result
  else
    print('Error running command: ' .. cmd)
    return nil
  end
end

M.exec = exec


-- Works like Clojure's `map`
--
local function map(tbl, f)
  local t = {}
  for k,v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end


function M.list_notes()

  local notes_json = note_index('list')
  local notes = vim.json.decode(notes_json)

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  pickers.new({
      finder = finders.new_table({
          results = notes,
          entry_maker = function(note)
            return {
              value = note,
              display = note.title,
              ordinal = note.title,
              path = notes_dir .. '/' .. note.path,
            }
          end,
        }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
      layout_strategy = 'vertical',
    }):find()

end

function M.index_notes()
  print('Indexing notes...')
  local result = note_index('index')
  print(result)
end

return M
