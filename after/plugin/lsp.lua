-- https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80
local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require("mason-lspconfig")
local cmp = require('cmp')
local luasnip = require('luasnip')
local mason_null_ls = require("mason-null-ls")
local null_ls = require('null-ls')
local lsp_saga = require("lspsaga")

lsp_saga.setup({
  diagnostic = {
    on_insert = true,
    on_insert_follow = false
  },
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

  -- goto: Definition
  -- vim.keymap.set('n', 'gd', "<CMD>Lspsaga goto_definition<CR>", opts)
  vim.keymap.set('n', 'gd', "<CMD>Lspsaga peek_definition<CR>", opts)

  -- goto: Type Definition <C-t>
  -- vim.keymap.set('n', 'gt', "<CMD>Lspsaga goto_type_definition<CR>", opts)
  vim.keymap.set('n', 'gt', "<CMD>Lspsaga peek_type_definition<CR>", opts)

  -- goto: outline (toggle)
  vim.keymap.set('n', 'go', "<CMD>Lspsaga outline<CR>", opts)

  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)

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

--------------------------------------------
-- Formatters (null-ls)
--------------------------------------------

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
    'prettierd'
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
      ['astro-language-server'] = { 'astro' },
      ['solargraph'] = { 'ruby' }
    }
  }
end

-- Format on save (Synchronous)
-- Set language specififc Format servers explicitly.
lsp_zero.format_on_save(fmt_opts())

-- Set language specififc Format servers explicitly.
lsp_zero.format_mapping('<leader>fs', fmt_opts())

--------------------------------------------
-- Diagnostics
--------------------------------------------
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

----------------------------------------------
-- AutoCompletion
----------------------------------------------


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
