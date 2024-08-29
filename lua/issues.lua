-- Retrieve issues from GitLab
--
-- Uses the gitlab-issues script to retrieve issues and envchain
-- to retrieve the GitLab access token from the keychain and set up the
-- proper environment variables.  Both must be on the path.
--

local function find_issues()

  local stdout;
  local job_id = vim.fn.jobstart('envchain gitlab gitlab-issues', { on_stdout = function (_, data, _) stdout = data end, stdout_buffered = true })
  vim.fn.jobwait({ job_id })

  local issues = {}

  for _, s in ipairs(stdout) do
    if string.len(s) > 0 then
      table.insert(issues, s)
    end
  end

  return issues

end

local function put_one()

  local issues = find_issues()

  vim.ui.select(issues, { prompt = 'Select Issue' },
    function (issue)
      if issue then
        vim.api.nvim_put({ issue }, 'l', false, true)
      end
    end)

end


local function put_todo()

  local issues = find_issues()

  for _, issue in ipairs(issues) do
    if string.len(issue) > 0 then
      vim.api.nvim_put({ '* [ ] ' .. issue }, 'l', false, true)
    end
  end

end


return {
  find_issues = find_issues,
  put_one = put_one,
  put_todo = put_todo,
}
