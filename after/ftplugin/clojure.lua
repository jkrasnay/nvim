vim.bo.shiftwidth = 2

-- span macro defined in Erbium
vim.opt_local.lispwords:append({ 'span' })

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = "getline(v:lnum)=~'^;;--'?'>1':1"
vim.wo.foldlevel = 1

--[[
"
" By default, J leaves spaces before ] and }
" Thanks to @Sigve on Clojurians Slack
fun ClojureJ()
    let l:line = getline('.')
    let l:line = substitute(l:line, '\s\+\([]}]\)', '\1', "g")
    let l:line = substitute(l:line, '\([[{]\)\s\+', '\1', "g")
    call setline('.', l:line)
endfun
nnoremap <buffer> J J:call ClojureJ()<cr>
vnoremap <buffer> J J:call ClojureJ()<cr>
--]]
