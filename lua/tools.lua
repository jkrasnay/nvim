-- Tools
--
-- Run tools in new windows.
--

local tools_file = 'tools.json'

local project_markers = {'.git', 'pom.xml', 'package.json', 'deps.edn'}

local last_tool = { }

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


local function load_config(config_file)
  local f = assert(io.open(config_file, 'r'))
  local s = f:read('*all')
  f:close()
  return vim.json.decode(s)
end


local function run_tool(tool_name)

  local config_file = find_config_file()
  if not config_file then
    print('No ' .. tools_file .. ' found')
    return
  end

  local config = load_config(config_file)
  local tool = config[tool_name]

  if not tool then
    print("No tool '" .. tool_name .. "' found in " .. config_file)
    return
  end

  if not tool.cmd then
    print("Tool '" .. tool_name .. "' in " .. config_file .. " has no 'cmd' entry")
    return
  end

  print('Running tool: ' .. tool_name)

  last_tool[config_file] = tool_name

  local buf_name = config_file .. '/' .. tool_name

  if vim.fn.bufexists(buf_name) > 0 then
    vim.cmd('bd! ' .. buf_name)
  end

  vim.cmd('bo new')
  vim.fn.termopen(tool.cmd, { cwd = vim.fs.dirname(config_file) })
  vim.cmd.file(buf_name)
  vim.cmd.normal('G')

end


local function run_last_tool()

  local config_file = find_config_file()
  if not config_file then
    print('No ' .. tools_file .. ' found')
    return
  end

  local lt = last_tool[config_file]

  if lt then
    run_tool(lt)
  else
    print('No last tool for ' .. config_file)
  end

end


local function edit_config()

  local dir = find_project_dir()

  if dir then
    vim.cmd.edit(dir .. '/' .. tools_file)
  else
    print("Can't find a reasonable project dir")
  end

end


local function select_tool()

  local config_file = find_config_file()
  if not config_file then
    print('No ' .. tools_file .. ' found')
    return
  end

  local config = load_config(config_file)

  local tool_names = {}
  local i = 1
  for k, _ in pairs(config) do
    tool_names[i] = k
    i = i + 1
  end

  table.sort(tool_names)

  -- If there's a last tool for this config, show it first
  local lt = last_tool[config_file]
  if lt then
    local all_names = tool_names
    tool_names = { lt }
    for _, v in ipairs(all_names) do
      if v ~= lt then
        table.insert(tool_names, v)
      end
    end
  end

  vim.ui.select(tool_names, { prompt = 'Select Tool' },
    function (tool_name)
      run_tool(tool_name)
    end)

end

return {
  edit_config = edit_config,
  run_last_tool = run_last_tool,
  run_tool = run_tool,
  select_tool = select_tool,
}


