local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- UX
  'nvim-treesitter/nvim-treesitter',
  'mhartington/oceanic-next',

  {
    'dracula/vim',
    lazy = false,
  },
  'bluz71/vim-nightfly-colors',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  -- navigation
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  'nvim-tree/nvim-tree.lua',
  'dinhhuy258/sfm.nvim',
  'theprimeagen/harpoon',

  -- lsp
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { "github/copilot.vim" },

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
      "rafamadriz/friendly-snippets",
      'saadparwaiz1/cmp_luasnip',

      -- Formatters
      "lukas-reineke/lsp-format.nvim",
    }
  },

  'lewis6991/gitsigns.nvim',
  'vim-test/vim-test',
  'preservim/vimux',
  'tpope/vim-fugitive',

  -- not setup yet
  'christoomey/vim-tmux-navigator',
  'tpope/vim-commentary',

  -- debugging
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'simrat39/rust-tools.nvim',

  -- Linters
  'mfussenegger/nvim-lint',


  -- misc
  'mbbill/undotree',
}

local opts = {}

require("lazy").setup(plugins, opts)
