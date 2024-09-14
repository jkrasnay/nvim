return {
  'guns/vim-sexp',
  dependencies = {
    'tpope/vim-sexp-mappings-for-regular-people'
  },
  config = function()
    vim.g.sexp_filetypes = 'clojure,scheme,lisp,timl,racket,pie'
  end
}
