-- https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80
local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require("mason-lspconfig")
local cmp = require('cmp')

-- Configure LSP Servers
lsp_zero.extend_lspconfig()
mason.setup()
mason_lspconfig.setup()

-- Use for loop and call setup or use setup_handlers and call setup
-- local get_servers = mason_lspconfig.get_installed_servers
-- for _, server_name in ipairs(get_servers()) do
  -- lsp_config[server_name].setup({})
-- end

mason_lspconfig.setup_handlers({
  function(server_name)
    lsp_config[server_name].setup({})
  end,
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
  -- language specific configutaion can be added as below
  -- ['tsserver'] = function()
    --require('lspconfig').tsserver.setup({
      --on_attach = function(client, bufnr)
        --print('hello tsserver')
      --end,
      --settings = {
        --completions = {
          --completeFunctionCalls = true
        --}
      --}
    --})
  --end
})

-- Diagnostic Config
lsp_zero.set_sign_icons()
vim.diagnostic.config(lsp_zero.defaults.diagnostics({}))

-- Snippet Config
require('luasnip').config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

require('luasnip.loaders.from_vscode').lazy_load()


-- AutoCompletion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp_config = lsp_zero.defaults.cmp_config({})

cmp.setup(cmp_config)
