"setlocal comments=f:*,f:-
"setlocal formatoptions+=r
setlocal conceallevel=3
setlocal spell
setlocal textwidth=80

lua << EOF
function asciidoctor_goto_link()
    s = vim.api.nvim_get_current_line()
    _,j = string.find(s, "link:")
    if j then
        i,_ = string.find(string.sub(s, j+1, -1), "http")
        if i == 1 then
            cmd = "gx"
        else
            cmd = "gf"
        end
        -- g0 - go to first column
        -- l  - move right by 'j' columns
        -- gf - go to file under cursor
        -- gx - go to URL under cursor
        vim.api.nvim_command("normal g0" .. j .. "l" .. cmd)
    end
end
EOF

nnoremap <buffer> <cr> :w<cr>:lua asciidoctor_goto_link()<cr>

nnoremap <localleader>l ilink:<c-r>+[]<left>
