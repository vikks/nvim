local vo        = vim.o
local vopt      = vim.opt
local vopt_global  = vim.opt_global
local vg        = vim.g

vg.mapleader = ','
vg.maplocalleader = ','

vopt.backspace = '2'
vopt.showcmd = true
vopt.laststatus = 2
vopt.autowrite = true
vopt.autoread = true

-- use spaces for tabs
vopt.tabstop = 2
vopt.shiftwidth = 2
vopt.shiftround = true
vopt.expandtab = true

vopt.swapfile = false
vopt.backup = false
-- vim.opt.undofile = true
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

--Line numbers
vopt.nu = true
vopt.relativenumber = true

-- search
vopt.hlsearch = true
vopt.incsearch = true

-- indent
vopt.smartindent = true

-- wrap
vopt.wrap = false

-- Vim Context to show 
vopt.scrolloff = 8

vopt.signcolumn = 'yes'
vopt.isfname:append("@-@")

vopt.updatetime = 50

-- Set to auto read when a file is changed from the outside
vopt.autoread = true

-- Set splits to below and right ( affects fugitive and others alike)
vopt.splitbelow = true
vopt.splitright = true

-- Prompt before closing window, useful when working with floats and terminal buffers
vopt.confirm = true

-- Clipboard
vopt.clipboard:append('unnamedplus')

-- Enhance command-line completion
vg.wildmenu = true

-- Hide buffers when abandoned ( useful when refactoring )
vg.hidden = true

-- Set command height
vopt.cmdheight = 0

-- When searching try to be smart about cases
vopt.smartcase = true

-- Don't redraw while executing macros (good performance config)
vopt.lazyredraw = true

-- Show matching brackets when cursor is over them.
vopt.showmatch = true

-- Highlight long lines ( beyond 80 characters)
vim.cmd [[ match ErrorMsg '\%>80v.\+'  ]]
