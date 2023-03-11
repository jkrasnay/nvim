-- Interaction with files in my Notes directory
--
-- These are all asciidoc files
--

local notes_dir = "~/Dropbox/Notes"

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

return M



--[[
let g:notes_dir = "~/Dropbox/Notes"

function! Diary()
    call mkdir(expand(g:notes_dir . strftime("/Diary/%Y/%m")), "p")
    execute "e " . g:notes_dir . strftime("/Diary/%Y/%m/%F.adoc")
    if line("$") == 1
        call append(0, "= " . strftime("%F"))
        call append(1, "")
    endif
endfunction

function! NewNote()
    call mkdir(expand(g:notes_dir . strftime("/%Y")), "p")
    execute "e " . g:notes_dir . strftime("/%Y/%Y%m%d%H%M%S.adoc")
endfunction

command! Diary call Diary()
command! NewNote call NewNote()
command! Notes execute "e " . g:notes_dir . "/index.adoc"

" Search notes: :Ns something
command! -nargs=1 Ns execute 'Ag <args> "' . expand(g:notes_dir) . '"'

--]]
