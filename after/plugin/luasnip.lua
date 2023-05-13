local luasnip = require('luasnip')

luasnip.config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

-- Add rails snippets to ruby filetype.
luasnip.filetype_extend('ruby', { 'rails' })

require('luasnip.loaders.from_vscode').lazy_load()
