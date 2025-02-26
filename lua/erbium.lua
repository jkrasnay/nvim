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
    vim.fn.chansend(vim.b.terminal_job_id, cmd)
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
    create_tool_buffer('erbium-tailwind', 'npx @tailwindcss/cli -i src/main/css/tailwind-input.css -o target/classes/public/css/tailwind-output.css --watch\n')
    create_tool_buffer('erbium-docker', 'cd tools/dev-env && docker compose up\n')
    vim.fn.serverstart('/tmp/nvim.erbium')
    is_up = true
  end, {})

create_clojure_command('ErbStart', "(do (require 'erbium.server.main) (require 'erbium.server.system) (erbium.server.system/start :dev))")
create_clojure_command('ErbStop', "(do (require 'erbium.server.system) (erbium.server.system/stop))")
create_clojure_command('ErbStartDev', "(do (require 'erbium.dev.dashboard.server) (erbium.dev.dashboard.server/start))")
create_clojure_command('ErbFlowStorm', "(do (require 'flow-storm.api) (flow-storm.api/local-connect {:theme :dark :verbose? true}))")
create_clojure_command('ErbPortal', "(do (require '[portal.api :as p]) (p/open) (add-tap #'p/submit))")


-- ClojureScript REPL  --------------------------------------------------


local function cljs_repl()
  vim.cmd.ConjureClientState('cljs')
  if not require('conjure.client.clojure.nrepl.server')['connected?']() then
    vim.notify('Connecting to CLJS REPL')
    local port = vim.fn.readfile('.shadow-cljs/nrepl.port')[1]
    vim.cmd.ConjureConnect(port)
    vim.cmd.ConjureShadowSelect('app')
  end
end

vim.api.nvim_create_user_command('CljsRepl', cljs_repl, {})
vim.api.nvim_create_user_command('CljRepl', function() vim.cmd.ConjureClientState('default') end, {})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set correct Conjure client state for Clojure REPLs',
  group = vim.api.nvim_create_augroup('set-clj-client-state', { clear = true }),
  pattern = { '*.clj', '*.cljc' },
  command = ':CljRepl',
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set correct Conjure client state for ClojureScript REPLs',
  group = vim.api.nvim_create_augroup('set-cljs-client-state', { clear = true }),
  pattern = '*.cljs',
  command = ':CljsRepl',
})
