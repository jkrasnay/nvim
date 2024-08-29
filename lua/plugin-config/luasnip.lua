local ls = require('luasnip')

local snip = ls.parser.parse_snippet

ls.add_snippets('all', {
    --snip('date `!v', 'strftime("%F")`')
    snip('->', '→'),
    snip('<-', '←'),
    snip('shrug', '¯\\_(ツ)_/¯'),
    snip('darr', '↓'),
    snip('drarr', '↳'),
    snip('larr', '←'),
    snip('rarr', '→'),
    snip('uarr', '↑'),
    snip({ trig='deg', wordTrig=false }, '°'),
    snip('therefore', '∴'),
    snip('delta', 'Δ'),
    snip('epsilon', 'ε'),
    snip('lambda', 'λ'),
    snip('mu', 'μ'),
    snip('theta', 'θ'),
    snip('Pi', 'Π'),
    snip('Sigma', 'Σ'),
    snip('1/2', '½'),
    snip('1/3', '⅓'),
    snip('2/3', '⅔'),
    snip('1/4', '¼'),
    snip('3/4', '¾'),
    snip('1/8', '⅛'),
    snip('3/8', '⅜'),
    snip('5/8', '⅝'),
    snip('7/8', '⅞'),
})

ls.add_snippets('asciidoctor', {
    snip('code', '----\n$1\n----'),
    snip('link', 'link:$1[$2]'),
    snip('xref', 'xref:$1[$2]'),
    snip('table', '[%autowidth]\n|===\n| $1\n|==='),
    snip('todo', '* [ ] $1'),
})

ls.add_snippets('clojure', {
    snip(';;-', ';;-- $1 ----------------------------------------------------------\n'),
    snip('clj', '#?(:clj\n   $1)'),
    snip('@clj', '#?@(:clj\n    [$1])'),
    snip('cljs', '#?(:cljs\n   $1)'),
    snip('@cljs', '#?@(:cljs\n    [$1])'),
    snip('jdbc', '(jdbc/with-db-transaction [db-conn (req/db-pool req)]\n  $1)'),
})

ls.add_snippets('java', {
    snip('main', 'public static void main(String[] args) {\n  $1\n}\n\n'),
    snip('list', 'List<$1> $2 = new ArrayList<>();'),
    snip('map', 'Map<$1, $2> $3 = new HashMap<>();'),
    snip('pubs', 'public static void $1 $2($3) {\n  $4\n}\n\n'),
    snip('print', 'System.out.println("$1");'),
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
