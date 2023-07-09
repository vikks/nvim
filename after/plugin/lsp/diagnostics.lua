--------------------------------------------
-- Diagnostics (https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80)
--------------------------------------------
local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require("mason-lspconfig")
local lsp_saga = require("lspsaga")

lsp_saga.setup({
  diagnostic = {
    on_insert = true,
    on_insert_follow = false
  },
  symbol_in_winbar = {
    separator = " > ",
    respect_root = true
  }
})

mason.setup()

mason_lspconfig.setup({
  -- Manually add lsp, linters, daps here
  ensure_installed = {
    'tsserver',
    'eslint',
    'solargraph',
    'lua_ls',
    'tailwindcss',
    'astro'
  }
})

-- Configure LSP Servers
lsp_zero.extend_lspconfig({
  -- init_options = {
  --   documentFormatting = false
  -- },
  -- on_attach = function(_, bufnr)
  -- end,
  -- capabilities = {
  --   textDocument = {
  --     foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly     = true
  --     }
  --   }
  -- },
})

-- Ovverwrite lsp_zero on_attach.
lsp_zero.on_attach(function(_, bufnr)
  -- if one formatter per file is used, order is not guranteed is used with multiple
  -- formatters for a single file.
  -- lsp.default_keymaps({buffer = bufnr})
  local opts = { buffer = bufnr, remap = false }

  -- Navigation ------------------------------------------------

  -- <C-w>w
  vim.keymap.set('n', 'K', "<CMD>Lspsaga hover_doc ++keep<CR>", opts)

  -- peak: Type/Definition <C-t> to jump back
  vim.keymap.set('n', 'pd', "<CMD>Lspsaga peek_definition<CR>", opts)
  vim.keymap.set('n', 'pt', "<CMD>Lspsaga peek_type_definition<CR>", opts)

  -- goto: Type/Definition
  vim.keymap.set('n', 'gd', "<CMD>Lspsaga goto_definition<CR>", opts)
  vim.keymap.set('n', 'gt', "<CMD>Lspsaga goto_type_definition<CR>", opts)

  -- goto: outline (toggle)
  vim.keymap.set('n', 'go', "<CMD>Lspsaga outline<CR>", opts)

  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)

  -- call hirarchy
  vim.keymap.set('n', '<leader>ci', "<CMD>Lspsaga incoming_calls<CR>")
  vim.keymap.set('n', '<leader>co', "<CMD>Lspsaga outgoing_calls<CR>")

  -- Diagnostics ------------------------------------------------

  vim.keymap.set('n', '<space>dl', "<CMD>Lspsaga show_line_diagnostics<CR>", opts)
  vim.keymap.set('n', '<space>db', "<CMD>Lspsaga show_buf_diagnostics<CR>", opts)
  vim.keymap.set('n', '<space>dw', "<CMD>Lspsaga show_workspace_diagnostics<CR>", opts)
  vim.keymap.set('n', '<space>dc', "<CMD>Lspsaga show_cursor_diagnostics<CR>", opts)
  -- vim.keymap.set('n', '<space>e', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<space>e', function() vim.diagnostic.setloclist() end, opts)
  vim.keymap.set('n', '[d', "<CMD>Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set('n', ']d', "<CMD>Lspsaga diagnostic_jump_next<CR>", opts)
  vim.keymap.set("n", "[e", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  vim.keymap.set("n", "]e", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)

  -- Actions
  vim.keymap.set('n', '<leader>ca', "<CMD>Lspsaga code_action<CR>", opts)
  vim.keymap.set('v', '<leader>ca', "<CMD>Lspsaga code_action<CR>", opts)
  vim.keymap.set('n', '<leader>rf', "<CMD>Lspsaga rename<CR>", opts)
  vim.keymap.set('n', '<leader>rp', "<CMD>Lspsaga rename ++project<CR>", opts)

  -- Workspace
  vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
  vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  vim.keymap.set('n', '<leader>ws', function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  -- vim.keymap.set("n", "<leader>f", function()
  --   -- vim.lsp.buf.format()
  --   vim.lsp.buf.format({ async = true, timeout_ms = 3000 })
  -- end)
end)

lsp_zero.set_sign_icons()
vim.diagnostic.config(lsp_zero.defaults.diagnostics({
  virtual_text = true,
  -- signs = true,
  -- update_in_insert = true,
  underline = true,
  severity_sort = true,
  -- float = {
  --   border = 'rounded',
  --   source = 'always'
  -- }
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
