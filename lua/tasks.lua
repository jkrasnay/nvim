-- Tasks
--
-- Run tasks for the current project.
--
-- Looks for config files for various common tools (Maven, Babashka, NodeJS,
-- etc) and offers to run one of their tasks.
--

-- Each different kind of task (e.g. Babashka) has a function that looks for
-- a corresponding config file in each parent directory.  If found, the function
-- returns a sequence of tables, each with the following keys:
--
-- file - Name of the config file
-- cmd  - Command line to invoke the task
--
-- If selected, we run the command in the same directory of the config file
--

local function starting_dir()

  local buffer_file = vim.api.nvim_buf_get_name(0)

  if vim.fn.filereadable(buffer_file) > 0 then
    return vim.fs.dirname(buffer_file)
  else
    return vim.fn.getcwd()
  end

end


local function find_bb_tasks()

  local bb_edn = vim.fs.find('bb.edn', { upward = true, path = starting_dir() })[1]

  if bb_edn then
    local dir = vim.fs.dirname(bb_edn)
    local stdout;
    local job_id = vim.fn.jobstart('bb tasks', { cwd = dir, on_stdout = function (_, data, _) stdout = data end, stdout_buffered = true  })
    vim.fn.jobwait({ job_id })

    local tasks = {}

    for i, s in ipairs(stdout) do
      if i > 2 and string.len(s) > 0 then
        local task = string.gmatch(s, '[^%s]+')()
        table.insert(tasks, { file = bb_edn, cmd = 'bb '..task })
      end
    end

    return tasks;

  else
    return {}
  end

end


local function find_mvn_tasks()

  local pom_xml = vim.fs.find('pom.xml', { upward = true, path = starting_dir() })[1]

  if pom_xml then

    return {
      { file = pom_xml, cmd = 'mvn clean' },
      { file = pom_xml, cmd = 'mvn clean install' },
      { file = pom_xml, cmd = 'mvn clean package' },
    };

  else
    return {}
  end

end


local function run_task(task)

  print('Running task: ' .. task.cmd)

  -- last_tool[config_file] = tool_name

  local dir = vim.fs.dirname(task.file)
  local buf_name = 'task:' .. dir .. ':' .. task.cmd

  if vim.fn.bufexists(buf_name) > 0 then
    vim.cmd('bd! ' .. buf_name)
  end

  vim.cmd('bo new')
  vim.fn.termopen(task.cmd, { cwd = dir })
  vim.cmd.file(buf_name)
  vim.cmd.normal('G')

end


local function select_task()

  local tasks = {}

  for _, task in ipairs(find_bb_tasks()) do
    table.insert(tasks, task)
  end

  for _, task in ipairs(find_mvn_tasks()) do
    table.insert(tasks, task)
  end

  if #tasks == 0 then
    print('No tasks found')
    return
  end

  -- table.sort(tool_names)

  -- If there's a last tool for this config, show it first
  --[[
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
  --]]

  --
  -- Problem: what to attach the "last task" run?
  -- Maybe just give in and always assume cwd, then we can just use vim.fn.system()
  -- This probably limits shareability, though
  -- Or, just use the dir of the task file as the "last task" anchor
  -- Hrm, that doesn't work, since the last task is only interesting when selecting a taks
  --
  -- OK, how's this:
  --   * Each time a task is invoked, remove all tasks in the last_invoked list that appear
  --     in the current list of tasks, then add the invoked task
  --   * Each time we show a list of tasks, look for any of those tasks in last_invoked.
  --     If found, that task is shown first

  vim.ui.select(tasks, { prompt = 'Select Tool', format_item = function (task) return task.cmd end },
    function (task)
      run_task(task)
    end)

end
return {
  select_task = select_task,
}