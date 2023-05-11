local sfm_explorer = require("sfm").setup()

sfm_explorer:load_extension('sfm-git')
sfm_explorer:load_extension("sfm-fs", {
  view = {
    render_selection_in_sign = true
  },
  mappings = {
    custom_only = false,
    list = {
      { key = 'n', action = 'create'},
      { key = 'c', action = 'copy'},
      { key = 'm', action = 'move'},
      { key = 'd', action = 'delete'},
    }
  }
})

vim.keymap.set('n', '<c-n>', ':SFMToggle<CR>')
