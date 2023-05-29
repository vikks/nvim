----------------------------------------------
-- AutoCompletion
----------------------------------------------
local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')


local cmp_action = lsp_zero.cmp_action()

local cmp_config = lsp_zero.defaults.cmp_config({
  preselect = 'item',
  sources = {
    {
      name = 'luasnip',
      keyword_length = 2,
      options = {
        show_autosnippets = true
      }
    },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer',  keyword_length = 3 },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-p>'] = cmp_action.luasnip_jump_forward(),
    ['<C-n>'] = cmp_action.luasnip_jump_backward(),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },

    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = '[LSP]',
        luasnip  = '[Snippet]',
        buffer   = '[Buffer]',
        path     = '[Path]',
        nvim_lua = '[nvim]'
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end
  }
})

cmp.setup(cmp_config)
