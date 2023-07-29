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

local function clojure_command(cmd, src)
  vim.api.nvim_create_user_command(cmd,
    function()
      assert_erbium()
      assert_clojure()
      vim.cmd.ConjureEval(src)
    end, {})
end

vim.api.nvim_create_user_command('ErbUp',
  function()

    assert_erbium()

    vim.cmd.vnew()

    vim.cmd.term()
    vim.cmd.file('repl')
    vim.fn.jobsend(vim.b.terminal_job_id, 'bb nrepl\n')

    vim.cmd.term()
    vim.cmd.file('test')
    vim.fn.jobsend(vim.b.terminal_job_id, 'bb test --watch\n')

    vim.cmd.term()
    vim.cmd.file('shadow')
    vim.fn.jobsend(vim.b.terminal_job_id, 'npx shadow-cljs watch app\n')

    vim.cmd.term()
    vim.cmd.file('docker')
    vim.fn.jobsend(vim.b.terminal_job_id, 'cd tools/dev-env && docker-compose up\n')

  end, {})

clojure_command('ErbStart', "(do (require 'erbium.server.main) (require 'erbium.server.system) (erbium.server.system/start :dev))")
clojure_command('ErbStop', "(do (require 'erbium.server.system) (erbium.server.system/stop))")
clojure_command('ErbStartDev', "(do (require 'erbium.dev.dashboard.server) (erbium.dev.dashboard.server/start))")
clojure_command('ErbFlowStorm', "(do (require 'flow-storm.api) (flow-storm.api/local-connect))")
clojure_command('ErbPortal', "(do (require '[portal.api :as p]) (p/open) (add-tap #'p/submit))")
