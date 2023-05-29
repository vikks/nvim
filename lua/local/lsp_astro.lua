local astro = { options = {}, plugins = { init = {} } }

-- Ignore this
astro.options.opt = {
  number         = false,
  relativenumber = false,
  scrolloff      = 2,
}

astro.plugins['null-ls'] = function(config)
  local null_ls = require('null-ls')
  local formatting = null_ls.builtins.formatting

  config.on_attach = function(client, bufnr)
    local bufcmd = vim.api.nvim_buf_create_user_command
    local format = function()
      local params = vim.lsp.util.make_formatting_params({})
      client.request('textDocument/formatting', params, nil, bufnr)
    end

    bufcmd(bufnr, 'NullFormat', format, { desc = 'Format using null-ls' })

    vim.keymap.set('n', '<C-f>', '<cmd>NullFormat<cr>', { buffer = true })
  end

  config.sources = {
    formatting.prettier
  }

  return config
end

return astro
