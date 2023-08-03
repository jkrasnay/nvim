-- Have each tab represent a separate project
-- Use :tcd to change the tab-current-directory to the project home directory
-- More commands to come, e.g. something like :OpenProject to
--   - find the project for the current file (e.g. folder containing .git, pom.xml, etc.)
--   - switch to that tab if exists
--   - else create a new tab and :tcd it to the project dir
--     maybe moving the current buffer to that new tab's window
-- Maybe some way to bookmark a project, and to quickly open and/or switch to that project's tab


-- Set up tabline ------------------------------------------------------------

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

-- Module functions ------------------------------------------------------------

--- Returns the number of the tab whose cwd is `dir_name`, or nil
local function tab_for_dir(dir_name)
    for index = 1, vim.fn.tabpagenr('$') do
        local tab_dir = vim.fn.getcwd(-1, index)
        if tab_dir == dir_name then
            return index
        end
    end
    return nil
end

--- Changes to the tab whose tcd is `dir_name`, creating it if necessary
local function open_project(dir_name)
    local tab_nr = tab_for_dir(dir_name)
    if tab_nr then
        vim.cmd.normal(tab_nr .. 'gt')
    else
        vim.cmd('$tabnew')
        vim.cmd('tcd ' .. dir_name)
        require('oil').open(dir_name)
    end
end

local function select_project()

    local items = {}

    if vim.g.projects then
        for _, dir in ipairs(vim.g.projects) do
            table.insert(items, vim.fn.expand(dir))
        end
    end

    table.insert(items, vim.fn.stdpath('config'))

    if vim.g.notes_dir then
        table.insert(items, vim.fs.normalize(vim.g.notes_dir))
    end

    vim.ui.select(items, { prompt = 'Select Project' },
        function(item)
            if item then
                open_project(item)
            end
        end)
end

return {
    tab_for_dir = tab_for_dir,
    open_project = open_project,
    select_project = select_project
}
