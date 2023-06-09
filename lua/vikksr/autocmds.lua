-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings:
--------------------

-- AUGroups
augroup('YankHighlight', { clear = true })
augroup('CursorGrp', { clear = true })
augroup('TrackExternalFileChange', { clear = true })
augroup('DetectFileType', { clear = true })
-- augroup('Twilight', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Show Cursor line only on active windows and in normal mode.
autocmd({ "InsertLeave", "WinEnter" }, {
  group   = 'CursorGrp',
  pattern = "*",
  command = 'set cursorline',
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group   = 'CursorGrp',
  pattern = "*",
  command = 'set nocursorline',
})

-- GoTo last location of cursor when on buffer open.
autocmd("BufReadPost", {
  group = 'CursorGrp',
  pattern = "*",
  command = [[
        if line("'\"") > 0 && line("'\"") <= line("$") |
          execute "normal! g`\"" |
        endif
     ]]
})

-- Reload the file when it's changed outside of vim
autocmd("FocusGained", {
  group = 'TrackExternalFileChange',
  command = [[:checktime]]
})

-- Notify when file changes outside of nvim session
autocmd("FileChangedShellPost", {
  group = 'TrackExternalFileChange',
  callback = function()
    print("File Changed on disk, Buffer reloaded!")
  end
})

-- Enable Twilight on Buffer Enter
-- autocmd('WinEnter', {
--   group = 'Twilight',
--   pattern = '*',
--   command = [[ :TwilightEnable ]]
-- })
--

-- Prisma file specific settings
autocmd({ 'BufNewFile', 'BufRead' }, {
  group    = 'DetectFileType',
  pattern  = '*.prisma',
  callback = function()
    vim.cmd('setlocal filetype=prisma')
    vim.cmd('setlocal iskeyword+=@-@')
    vim.cmd('setlocal comments=://')
    vim.cmd('setlocal commentstring=//%s')
  end
})
