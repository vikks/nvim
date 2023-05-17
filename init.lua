----------------------------------------------------------
-- Requirements
----------------------------------------------------------
-- System: fzf (brew)
--         solargraph (gem)
--         prettierd (npm -g / brew)
--         tmux (brew)

require("vikksr.options")
require("vikksr.keymaps")
require("vikksr.packages")
require("vikksr.autocmds")
require("vikksr.user-commands")


-- TODO
-- Treesitter does not yet support erb and other embedded filetypes.
-- So, html.erb files don't look good.
-- Solution:
--  Try vim-polyglot plugin and disabling for everyother filetypes
--  except for html.erb/eruby filetypes and let vim-polyglot take care of
--  these files
