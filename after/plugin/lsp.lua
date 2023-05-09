local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local lsp_config = require("lspconfig")
local lsp_format = require("lsp-format")

-- Load snippets from friendly-snippets into nvim-cmp
require('luasnip.loaders.from_vscode').lazy_load()
-- if instead of friendly-snippets, we want to use `honza/vim-snippets`, then
-- require('luasnip.loaders.from_snipmate').lazy_load()

local lsp = lsp_zero.preset({})

-- (Optional) Configure lua language server for neovim
-- Else nvim/*.lua files keep showing lsp errors
lsp_config.lua_ls.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
  -- if one formatter per file is used, order is not guranteed is used with multiple
  -- formatters for a single file.
  -- lsp.default_keymaps({buffer = bufnr})
  local opts = { buffer = bufnr, remap = false }
  local allow_format = { 'lua_ls', }

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'td', function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<leader>cg', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('v', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>crn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
  vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<leader>ws', function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>cf", function()
    -- vim.lsp.buf.format()
    vim.lsp.buf.format({ async = true, timeout_ms = 3000 })
  end)

  if vim.tbl_contains(allow_format, client.name) then
    lsp_format.on_attach(client)
  end
end)


lsp.setup()

-- Make sure you setup `cmp` after lsp-zero

local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  mapping = {
    -- ['<Tab>'] = cmp_action.tab_complete(),
    -- ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    -- ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    -- changing the order of fields so the icon is the first
    fields = { 'menu', 'abbr', 'kind' },
  },
})
