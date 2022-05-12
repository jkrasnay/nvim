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
        if i == 1 then
            vim.api.nvim_command("normal g0" .. j .. "lgx")
        else
            vim.api.nvim_command("normal g0" .. j .. "lvt[gf")
        end
    end
end
EOF

nnoremap <buffer> <cr> :w<cr>:lua asciidoctor_goto_link()<cr>

nnoremap <localleader>l ilink:<c-r>+[]<left>
