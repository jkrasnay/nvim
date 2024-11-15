local is_up = false

local function assert_erbium()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(0), ':t')
  if cwd ~= 'erbium' then
    error('Not in the Erbium project')
  end
end

local function assert_clojure()
  if vim.bo.filetype ~= 'clojure' then
    error('Not in a Clojure file')
  end
end

local function create_clojure_command(cmd, src)
  vim.api.nvim_create_user_command(cmd,
    function()
      assert_erbium()
      assert_clojure()
      vim.cmd.ConjureEval(src)
    end, {})
end

local function create_tool_buffer(name, cmd)
    vim.cmd.term()
    vim.cmd.file(name)
    vim.fn.jobsend(vim.b.terminal_job_id, cmd)
end

vim.api.nvim_create_user_command('ErbUp',
  function()
    assert_erbium()
    if is_up then
      print('Erbium is already up')
      return
    end
    vim.cmd.vnew()
    create_tool_buffer('erbium-repl', 'bb nrepl\n')
    create_tool_buffer('erbium-test', 'bb test --watch\n')
    create_tool_buffer('erbium-shadow', 'npx shadow-cljs watch app test\n')
    create_tool_buffer('erbium-docker', 'cd tools/dev-env && docker-compose up\n')
    vim.fn.serverstart('/tmp/nvim.erbium')
    is_up = true
  end, {})

create_clojure_command('ErbStart', "(do (require 'erbium.server.main) (require 'erbium.server.system) (erbium.server.system/start :dev))")
create_clojure_command('ErbStop', "(do (require 'erbium.server.system) (erbium.server.system/stop))")
create_clojure_command('ErbStartDev', "(do (require 'erbium.dev.dashboard.server) (erbium.dev.dashboard.server/start))")
create_clojure_command('ErbFlowStorm', "(do (require 'flow-storm.api) (flow-storm.api/local-connect {:theme :dark :verbose? true}))")
create_clojure_command('ErbPortal', "(do (require '[portal.api :as p]) (p/open) (add-tap #'p/submit))")
