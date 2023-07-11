-- Requirements in the Operating System level outside of neovim.
local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require("mason-lspconfig")

-- IMPORTANT: neodev needs to be setup before lsp_config
require('neodev').setup({})

-- mason.setup()

mason_lspconfig.setup({
  -- Manually add lsp, linters, daps here
  ensure_installed = {
    'tsserver',
    'eslint',
    'solargraph',
    'lua_ls',
    'tailwindcss',
    'astro',
    'clangd',
    'codelldb',
  }
})

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
          },
          completion = {
            callSnippet = "Replace"
          }
        }
      },
    })
  end,
  -- ['clangd'] = function()
  --   lsp_config.clangd.setup {
  --     on_attach = function(client, bufnr)
  --       client.server_capabilities.signatureHelpProvider = false
  --       lsp_config.on_attach(client, bufnr)
  --     end
  --   }
  -- end
})
