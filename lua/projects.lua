-- Have each tab represent a separate project
-- Use :tcd to change the tab-current-directory to the project home directory
-- More commands to come, e.g. something like :OpenProject to
--   - find the project for the current file (e.g. folder containing .git, pom.xml, etc.)
--   - switch to that tab if exists
--   - else create a new tab and :tcd it to the project dir
--     maybe moving the current buffer to that new tab's window
-- Maybe some way to bookmark a project, and to quickly open and/or switch to that project's tab


-- See: https://stackoverflow.com/a/76544483
function MyTabLine()
    local tabline = ""
    for index = 1, vim.fn.tabpagenr('$') do
        -- Select the highlighting for the current tabpage.
        if index == vim.fn.tabpagenr() then
            tabline = tabline .. '%#TabLineSel#'
        else
            tabline = tabline .. '%#TabLine#'
        end

        local win_num = vim.fn.tabpagewinnr(index)
        local working_directory = vim.fn.getcwd(win_num, index)
        local project_name = vim.fn.fnamemodify(working_directory, ":t")
        tabline = tabline .. " " .. project_name .. " "
    end

    return tabline
end

vim.go.showtabline = 2  -- always show tabline
vim.go.tabline = "%!v:lua.MyTabLine()"
