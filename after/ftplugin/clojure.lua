vim.bo.shiftwidth = 2

--vim.wo.foldmethod = 'marker'
--vim.wo.foldexpr=getline(v:lnum)=~'^;;--'?'<1':1

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
