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
