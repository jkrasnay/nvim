"setlocal comments=f:*,f:-
"setlocal formatoptions+=r
setlocal conceallevel=3
setlocal spell
setlocal textwidth=80

lua << EOF
function asciidoctor_goto_link()
    s = vim.api.nvim_get_current_line()
    _,j1 = string.find(s, "link:")
    _,j2 = string.find(s, "xref:")
    j = j1 or j2
    if j then
        i,_ = string.find(string.sub(s, j+1, -1), "http")
        -- g0  - go to first column
        -- l   - move right by 'j' columns
        -- vt[ - visual select to the next [ char
        -- gf  - go to file under cursor
        -- gx  - go to URL under cursor
        if i == 1 then -- ...this is a hyperlink
            vim.api.nvim_command("normal g0" .. j .. "lgx")
        else
            vim.api.nvim_command("normal g0" .. j .. "lvt[gf")
            -- Below I try to handle the case of a new file, but we have
            -- to be smarter here and tell vim to open the full path to
            -- the file, else it won't know where exactly to create the
            -- file with the relative pathname
            --vim.api.nvim_command("normal g0" .. j .. "l")
            --vim.api.nvim_command(":e <cfile>")
        end
    end
end
EOF

lua << EOF
function find_str(s, pat)
    i, j = string.find(s, pat)
    if j then
        return string.sub(s, i, j)
    else
        return nil
    end
end
EOF

lua << EOF
function asciidoctor_insert_bullet()
    s = vim.api.nvim_get_current_line()
    prefix = find_str(s, "^%*+ %b[] ") or find_str(s, "^%*+ ")
    if prefix then
        if s == prefix then
            -- line is blank, erase the prefix and enter insert mode
            vim.api.nvim_feedkeys("d0i\n", "m", true)
        elseif string.find(s, ":$") then
            vim.api.nvim_feedkeys("a\n*" .. prefix, "m", true)
        else
            vim.api.nvim_feedkeys("a\n" .. prefix, "m", true)
        end
    else
        vim.api.nvim_feedkeys("a\n", "m", true)
    end
end
EOF

nnoremap <buffer> <cr> :w<cr>:lua asciidoctor_goto_link()<cr>

nnoremap <localleader>l ilink:<c-r>+[]<left>

inoremap <buffer> <cr> <esc>:lua asciidoctor_insert_bullet()<cr>

