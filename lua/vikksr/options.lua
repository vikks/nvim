vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true

-- use spaces for tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.cmd [[ set noswapfile ]]

--Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- indent
vim.opt.smartindent = true

-- wrap
vim.opt.wrap = false

-- Vim Context to show 
vim.opt.scrolloff = 8

vim.opt.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
