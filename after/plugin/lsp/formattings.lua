--------------------------------------------
-- Formatters (null-ls)
--------------------------------------------
local lsp_zero = require('lsp-zero')
local mason_null_ls = require("mason-null-ls")
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- Replace these with the tools you want to install
    -- null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettierd,
  }
})

-- Manually List Formatters here
mason_null_ls.setup({
  ensure_installed = {
    'lua_ls',
    'prettierd',
    'prisma-language-server',
  },
  automatic_installation = false,
})

local fmt_opts = function()
  return {
    format_opts = {
      async = true,
      timeout_ms = 10000,
    },
    servers = {
      ['lua_ls'] = { 'lua' },
      ['null-ls'] = {
        'javascript',
        'typescript',
        'typescriptreact',
        'javascriptreact',
        'markdown',
      },
      ['prisma-language-server'] = { 'prisma' },
      ['astro-language-server'] = { 'astro' },
      ['solargraph'] = { 'ruby' },
      ['dartls'] = { 'dart' }
    }
  }
end

-- Format on save (Synchronous)
-- Set language specififc Format servers explicitly.
lsp_zero.format_on_save(fmt_opts())

-- Set language specififc Format servers explicitly.
lsp_zero.format_mapping('<leader>fs', fmt_opts())
