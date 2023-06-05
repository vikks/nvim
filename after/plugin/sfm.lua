local sfm_explorer = require("sfm").setup()

sfm_explorer:load_extension('sfm-git')
sfm_explorer:load_extension("sfm-fs", {
  view = {
    render_selection_in_sign = true
  },
  mappings = {
    custom_only = true,
    list = {
      { key = 'a', action = 'create' },
      { key = 'c', action = 'copy' },
      { key = 'm', action = 'move' },
      { key = 'd', action = 'delete' },
    }
  }
})
sfm_explorer:load_extension('sfm-filter', {
  show_hidden = true,
  ignore_names = {},
  mappings = {
    toggle_filter = { '.' }
  },
})
-- image pasting works only in MacOS with `pngpaste` lib.
if not (vim.loop.os_uname().sysname == "Linux") then
  sfm_explorer:load_extension('sfm-paste', {
    mappings = {
      paste = { "<C-v>", "p" }
    }
  })
end


vim.keymap.set('n', '<leader>e', ':SFMToggle<CR>')
