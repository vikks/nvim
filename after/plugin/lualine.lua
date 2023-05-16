-- Override 'encoding': Don't display if encoding is UTF-8.
local encoding = function()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
  return ret
end

-- fileformat: Don't display if &ff is unix.
local fileformat = function()
  local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
  return ret
end

local fmtrs = {
  function()
    local msg = 'No Formatters Found'
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })

    local formatters = vim.tbl_filter(function(c)
      return c.supports_method('textDocument/formatting')
    end, clients)

    formatters = vim.tbl_map(function(c)
      return c.name
    end, formatters)

    if #formatters > 0 then
      local fmts = vim.inspect(formatters)
      -- print(fmts)
      -- return fmts
    else
      -- print(msg)
      -- return msg
    end
  end,
  -- icon = 'Fmtr:',
  color = { fg = '#ffffff', gui = 'bold' }
}

local lsp = {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    local X = ""
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        X = client.name .. "," .. X
      end
    end
    if not (X == "") then
      return X:sub(1, -2)
    else
      return msg
    end
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' }
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'lsp_progress', lsp, fmtrs, encoding, fileformat, 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
