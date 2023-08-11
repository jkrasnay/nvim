-- Tools
--
-- Run tools in new windows.
--

local tools_file = 'tools.json'

local project_markers = {'.git', 'pom.xml', 'package.json', 'deps.edn'}


local function starting_dir()

  local buffer_file = vim.api.nvim_buf_get_name(0)

  if vim.fn.filereadable(buffer_file) > 0 then
    return vim.fs.dirname(buffer_file)
  else
    return vim.fn.getcwd()
  end

end


local function find_config_file()

  local dir = starting_dir()

  return vim.fs.find(tools_file, { upward = true, path = dir })[1]

end


local function find_project_dir()

  local dir = starting_dir()

  local found = vim.fs.find(project_markers, { upward = true, path = dir })[1]

  if found then
    return vim.fs.dirname(found)
  else
    return nil
  end

end


local function run_tool(tool_name, config, opts)

  if vim.fn.bufexists(tool_name) > 0 then
    vim.cmd('bd! ' .. tool_name)
  end

  vim.cmd('bo new')
  vim.fn.termopen(config[tool_name].cmd, opts)
  vim.cmd.file(tool_name)
  vim.cmd.normal('G')

end


-- Module definition
--

local M = {}


function M.edit_config()

  local dir = find_project_dir()

  if dir then
    vim.cmd.edit(dir .. '/' .. tools_file)
  else
    print("Can't find a reasonable project dir")
  end

end


function M.select_tool()

  local config_file = find_config_file()
  if not config_file then
    print('No ' .. tools_file .. ' found')
    return
  end

  local s = vim.fn.join(vim.fn.readfile(config_file), '\n')
  local config = vim.json.decode(s)

  local tool_names = {}
  local i = 1
  for k, _ in pairs(config) do
    tool_names[i] = k
    i = i + 1
  end

  table.sort(tool_names)

  vim.ui.select(tool_names, nil, function (tool_name)
    print('Running tool: ' .. tool_name)
    run_tool(tool_name, config, { cwd = vim.fs.dirname(config_file) })
    end)

end

return M
