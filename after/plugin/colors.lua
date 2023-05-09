-- vim.cmd [[ colorscheme dracula ]]

function ColorScheme(color)
  vim.o.termguicolors = true
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if buf_ft == 'ruby' or buf_ft == 'rb' then
    color = 'OceanicNext'
  else
    color =  color or 'dracula'
  end
  vim.cmd.colorscheme(color)

  -- Set transparent background
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFLoat", { bg = "none" })
end

-- FIXME: This does not seem to set color based on the buffer filetype as intended.
ColorScheme()
