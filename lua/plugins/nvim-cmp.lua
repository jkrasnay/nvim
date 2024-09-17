local function add_snippets()

  local ls = require('luasnip')

  local snip = ls.parser.parse_snippet
  local s = ls.snippet
  local f = ls.function_node

  ls.add_snippets('all', {
    s('date', { f(function() return vim.fn.strftime("%F") end) }),
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
    snip({ trig = '@clj', wordTrig = false }, '#?@(:clj\n    [$1])'),
    snip('cljs', '#?(:cljs\n   $1)'),
    snip({ trig = '@cljs', wordTrig = false }, '#?@(:cljs\n    [$1])'),
    snip('jdbc', '(jdbc/with-db-transaction [db-conn (req/db-pool req)]\n  $1)'),
  })

  ls.add_snippets('java', {
    snip('main', 'public static void main(String[] args) {\n  $1\n}\n\n'),
    snip('list', 'List<$1> $2 = new ArrayList<>();'),
    snip('map', 'Map<$1, $2> $3 = new HashMap<>();'),
    snip('pubs', 'public static void $1 $2($3) {\n  $4\n}\n\n'),
    snip('print', 'System.out.println("$1");'),
  })

end


return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    add_snippets()

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noselect' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
        -- Select the [n]ext item
        --['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        --['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        --['<CR>'] = cmp.mapping.confirm { select = true },

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      sources = {
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
  end,
}
