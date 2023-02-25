" Functions for helping with Clojure development.
"

setlocal shiftwidth=2

" Creates a namespace decl in the current buffer.
"
" Does not attempt to avoid an existing namespace decl.
"
" TODO
" - look for the following prefixes
"   - src/main/clj
"   - src/main/clojure
"   - src/test/clj
"   - src/test/clojure
"   - src/test/clojure
"   - src/clj
"   - src/clojure
"   - src
"
function! clojure#ns_from_filename()
    let ns = substitute(expand('%'), '.*src/[^/]*/clj/\(.*\)\.clj[cs]\?', '\1', '')
    return tr(ns, '/_', '.-')
endfunction

function! clojure#ns_decl()

    let filename = expand('%')
    let ns = clojure#ns_from_filename()
    let result = ['(ns ' . ns, '  (:require']

    if filename =~ "_test"
        call add(result, '    [clojure.test :refer [deftest is]]')
    endif

    if filename =~ "\.cljs$"
        call add(result, '    [re-frame.core :as rf]')
    endif

    call add(result, '    ))')
    return result

endfunction

function! clojure#insert_ns_decl()
    :normal gg
    :put! =clojure#ns_decl_from_filename()
    :normal gg
    search(':require')
    :normal i
endfunction

" Returns the name of the corresponding test file of the current Clojure file
function! clojure#test_file()
    " TODO: magic vs. non-magic?
    " TODO: specify case-sensitive
    " TODO: open the test file beside the current one
    " TODO: switch back to non-test namespace?
    let f1 = substitute(expand('%'), '\.clj[cs]\?', '_test&', '')
    return substitute(f1, 'src/main', 'src/test', '')
endfunction

command! ClojureGoToTest exec ':vnew ' . clojure#test_file()
command! ClojureInsertNs call append(0, clojure#ns_decl())

nnoremap <buffer> <LocalLeader>gt :ClojureGoToTest<cr>
nnoremap <buffer> <LocalLeader>n :ClojureInsertNs<cr>
nnoremap <buffer> <LocalLeader>cp :ConjurePiggieback (figwheel.main.api/repl-env "dev")<cr>
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

