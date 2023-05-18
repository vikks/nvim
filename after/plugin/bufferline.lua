local bufferline = require('bufferline')
bufferline.setup {
  options = {
    numbers = 'ordinal',
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. count .. icon
    end,
    show_buffer_icons = false,
    show_close_icon = false,
    show_buffer_close_icons = false,
    separator_style = 'slant',
    always_show_bufferline = false,
    offsets = {
      {
        filetype = "sfm",
        text = function()
          return vim.fn.hostname()
        end,
        text_align = "center",
        separator = true
      }
    }
  }
}

-- Buffer Navigation using absolute ordinal numbers.
vim.keymap.set('n', '<space>1', '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>2', '<cmd>lua require("bufferline").go_to_buffer(2, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>3', '<cmd>lua require("bufferline").go_to_buffer(3, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>4', '<cmd>lua require("bufferline").go_to_buffer(4, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>5', '<cmd>lua require("bufferline").go_to_buffer(5, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>6', '<cmd>lua require("bufferline").go_to_buffer(6, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>7', '<cmd>lua require("bufferline").go_to_buffer(7, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>8', '<cmd>lua require("bufferline").go_to_buffer(8, true)<cr>', { silent = true })
vim.keymap.set('n', '<space>9', '<cmd>lua require("bufferline").go_to_buffer(9, true)<cr>', { silent = true })

-- Reorder(Move) buffers left/right
vim.keymap.set("n", "<space>bn", "<cmd>BufferLineMoveNext<CR>")
vim.keymap.set("n", "<space>bp", "<cmd>BufferLineMovePrev<CR>")
