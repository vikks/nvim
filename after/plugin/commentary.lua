-- Default keymaps:
-- gc
-- gc2j, gc5j, gck, gcj, ...gc[num][movement]
-- gcc
-- gcap
-- :g/TODO/Commentary

vim.keymap.set("n", "<leader>/", "<Plug>CommentaryLine<CR>")
vim.keymap.set("v", "<leader>/", "<Plug>Commentary<CR>")
