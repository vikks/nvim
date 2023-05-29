local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)

local function header()
  -- Try these fonts
  -- Ascii fonts
  -- Ansi Shadow
  -- Dos Rebel

  local function days()
    return {
      ['Monday'] = {
        '',
        '███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗',
        '████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ',
        '██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ',
        '██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ',
        '╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
        '',
      },
      ['Tuesday'] = {
        '',
        '████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗',
        '╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '   ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ ',
        '   ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  ',
        '   ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║   ',
        '   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
        '',
      },
      ['Wednesday'] = {
        '',
        '██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗',
        '██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ ',
        '██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  ',
        '╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║   ',
        '',
      },
      ['Thursday'] = {
        '',
        '████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗',
        '╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '   ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝ ',
        '   ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝  ',
        '   ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║   ',
        '   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
        '',
      },
      ['Friday'] = {
        '',
        '███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗',
        '██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '█████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝ ',
        '██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝  ',
        '██║     ██║  ██║██║██████╔╝██║  ██║   ██║   ',
        '╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
        '',
      },
      ['Saturday'] = {
        '',
        '███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗',
        '██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝ ',
        '╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝  ',
        '███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║   ',
        '╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
        '',
      },
      ['Sunday'] = {
        '',
        '███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗',
        '██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝',
        '███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ',
        '╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ',
        '███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ',
        '╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
        '',
      },
    }
  end

  local default_title = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  }

  local day_fn = days()
  local daysoftheweek = { 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' }
  local today = day_fn[os.date("%A")]
  return today
end


local function footer()
  -- Number of plugins
  -- TODO: find Lazy plugin's version of packer_plugins
  -- local total_plugins = #vim.tbl_keys(packer_plugins)
  -- local plugins_text = "   "
  --   .. total_plugins
  -- .. " plugins"
  local plugins_text = "  V"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch

  -- Quote
  local fortune = require "alpha.fortune"
  local quote = table.concat(fortune(), "\n")
  return plugins_text .. "\n" .. quote
end

local function menu()
  return {
    dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "  > Settings",
      ":lua require('telescope.builtin').find_files({ cwd = '~/.config/nvim', prompt_title='Nvim Settings' }) <CR>"),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),

  }
end


dashboard.section.header.val  = header()
dashboard.section.buttons.val = menu()
dashboard.section.footer.val  = footer()

dashboard.opts.opts.noautocmd = true


-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
