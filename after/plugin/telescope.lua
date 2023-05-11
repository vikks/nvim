require("telescope").setup()
local builtin = require("telescope.builtin")

--------------------------------------------
-- Find 
--------------------------------------------

-- Find all files within the project
vim.keymap.set("n", "<leader>fp", builtin.find_files, {})

-- Find files while honoring .gitignore
vim.keymap.set("n", "<C-p>",      builtin.git_files, {})

-- Find within recetly opened files
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})

-- Find buffers
vim.keymap.set('n', "<leader>fb", builtin.buffers, {})

--------------------------------------------
-- Search
--------------------------------------------

-- Search project
vim.keymap.set("n", "<leader>sp", builtin.live_grep, {})

-- Search Vim help tags
vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})

-- Search Workspace Diagnostics
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {})
