local nmap = function(key, cmd)
  vim.keymap.set("n", key, cmd)
end
local vmap = function(key, cmd)
  vim.keymap.set("v", key, cmd)
end
local xmap = function(key, cmd)
  vim.keymap.set("x", key, cmd)
end

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- clear the search highlights
nmap('<leader>c', ':nohlsearch<CR>')

-- move selected lines/blocks up or down
vmap('J', ":m '>+1<CR>gv=gv")
vmap('K', ":m '>-2<CR>gv=gv")

vim.keymap.set('n', "Y", "yg$")

-- Cursor Position remains unchanged when using J
vim.keymap.set("n", "J", "mzJ`z")

-- Keeps the cursor in the middle when moving half page up or down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- When searching, keep the cursor on the search term in the middle.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste what's cut
xmap("p", "\"_dP")

-- Yank into the clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- don't do anything when Q is pressed
vim.keymap.set("n", "Q", "<nop>")

-- TODO: tmux and tmux-sessionizer setup to be done
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Quickfix Navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace the word under the cursor
nmap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Global mappings for non-lsp handled navigation via vim.
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

---------------- Buffers -----------------------
-- List open buffers
vim.keymap.set("n", "<leader>b", "<CMD>buffers<CR>")

-- Close all buffers except current
vim.keymap.set('n', "<leader>bo", "<CMD>BufOnly<CR>")

---------------- Debugger -----------------------
vim.keymap.set("n", "<leader>db", "<CMD> DapToggleBreakpoint <CR>")
vim.keymap.set("n", "<leader>ds", "<CMD> DapContinue <CR>")
