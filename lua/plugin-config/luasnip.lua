local ls = require('luasnip')

local snip = ls.parser.parse_snippet

ls.add_snippets('all', {
    --snip('date `!v', 'strftime("%F")`')
    snip('shrug', '¯\\_(ツ)_/¯'),
    snip('darr', '↓'),
    snip('larr', '←'),
    snip('rarr', '→'),
    snip('uarr', '↑'),
    snip({ trig='deg', wordTrig=false }, '°'),
    snip('therefore', '∴'),
    snip('delta', 'Δ'),
    snip('epsilon', 'ε'),
    snip('mu', 'μ'),
    snip('theta', 'θ'),
    snip('1/2', '½'),
    snip('1/3', '⅓'),
    snip('1/4', '¼'),
    snip('1/8', '⅛'),
})

ls.add_snippets('asciidoctor', {
    snip('link', 'link:$1[$2]'),
    snip('xref', 'xref:$1[$2]'),
    snip('table', '|===\n| $1\n|==='),
    snip('todo', '* [ ] $1'),
})

ls.add_snippets('clojure', {
    snip(';;=', ';;============================================================\n;; $1\n;;'),
    snip(';;-', ';;------------------------------------------------------------\n;; $1\n;;'),
    snip('clj', '#?(:clj\n   $1)'),
    snip('@clj', '#?@(:clj\n    [$1])'),
    snip('cljs', '#?(:cljs\n   $1)'),
    snip('@cljs', '#?@(:cljs\n    [$1])'),
    snip('jdbc', '(jdbc/with-db-transaction [db-conn (req/db-pool req)]\n  $1)'),
})

--[[

snip('rep (reg-endpoint :${1:module}/${2:endpoint}
  {:path "/api/path/to/$2"
   :post {:auth :public
          :param-spec (s/keys :req-un [])
          :body-spec any?
          #?@(:clj [:handler (request-data/fn->handler $2)])}})
endsnippet

snip('redb (rf/reg-event-db :${1:module}/${2:event}
  (fn [db _]
    $0
    db))
endsnippet

snip('refx (rf/reg-event-fx :${1:module}/${2:event}
  (fn [{:keys [db]} _]
    $0))
endsnippet

snip('rpage (reg-page :${1:module}/${2:page}
  {:path "/ui/$2"
   :auth :user
   :title [:$1 :$2 :title]
   #?@(:cljs [:init :$1/$2-init
              :render $2])})
endsnippet

snip('rsub (rf/reg-sub :${1:event}
  (fn [db _]
    $0))
endsnippet

--]]
