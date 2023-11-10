local cmp = require('cmp')

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
      ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
      }, {
        { name = 'buffer' },
      })
  })

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
      {
        { name = 'path' }
      },
      {
        {
          name = 'cmdline',
          keyword_length = 3,
        }
      })
  })


