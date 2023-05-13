-- https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80
local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require("mason-lspconfig")
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local luasnip_config = require('luasnip')

mason.setup()

mason_lspconfig.setup({
  -- Manually add lsp, linters, daps here
  ensure_installed = {
    'tsserver',
    'eslint',
    'solargraph',
    'lua_ls'
  }
})

-- Configure LSP Servers
lsp_zero.extend_lspconfig({
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<space>e', vim.lsp.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.lsp.diagnostic.setloclist)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>gI', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly     = true
      }
    }
  },
})


--------------------------------------------
-- Formatters
--------------------------------------------
-- Set language specififc Format servers explicitly.
lsp_zero.format_mapping('<leader>f', {
  format_opts = {
    async = true,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    -- ['prettier'] = { 'javascript' }
  }
})

-- Format on save (Synchronous)
lsp_zero.on_attach(function(_, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
  lsp_zero.buffer_autoformat()
end)
--------------------------------------------
-- Diagnostics
--------------------------------------------
lsp_zero.set_sign_icons()
vim.diagnostic.config(lsp_zero.defaults.diagnostics({
  virtual_text = true
}))


-- Use for loop and call setup or use setup_handlers and call setup
-- local get_servers = mason_lspconfig.get_installed_servers
-- for _, server_name in ipairs(get_servers()) do
-- lsp_config[server_name].setup({})
-- end

mason_lspconfig.setup_handlers({
  function(server_name)
    lsp_config[server_name].setup({})
  end,

  -- language specific configutaion can be added as below
  ['lua_ls'] = function()
    lsp_config.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      },
    })
  end
})

----------------------------------------------
-- AutoCompletion
----------------------------------------------

-- Snippet Config
luasnip_config.config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

require('luasnip.loaders.from_vscode').lazy_load()

local cmp_config = lsp_zero.defaults.cmp_config({
  preselect = 'item',
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer',  keyword_length = 3 },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
